import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../env.dart';

class ApiService {
  static http.Client? _client;

  Future<void> cancel() async {
    _client?.close();
    _client = null;
  }

  Future<String> streamChat(String prompt) async {
    final uri = Uri.parse('https://openrouter.ai/api/v1/chat/completions');
    _client = http.Client();

    final request =
        http.Request('POST', uri)
          ..headers.addAll({
            'Authorization': 'Bearer ${Env.openrouterKey}',
            'Content-Type': 'application/json',
            'Accept': 'text/event-stream',
          })
          ..body = jsonEncode({
            'model': 'meta-llama/llama-3-8b-instruct:nitro',
            'stream': true,
            'messages': [
              {'role': 'user', 'content': prompt},
            ],
          });

    final response = await _client!.send(request);

    final completer = Completer<String>();
    final buffer = StringBuffer();

    response.stream
        .transform(const Utf8Decoder())
        .listen(
          (chunk) {
            for (final line in chunk.split('\n\n')) {
              if (!line.startsWith('data:')) continue;

              final data = line.substring(5).trim();

              if (data == '[DONE]') {
                if (!completer.isCompleted) {
                  completer.complete(buffer.toString());
                }
                _client?.close();
                break;
              }

              try {
                final decoded = jsonDecode(data);
                final delta = decoded['choices'][0]['delta'];
                final content = delta?['content'];
                if (content != null) {
                  buffer.write(content);
                }
              } catch (e) {
                debugPrint('⚠️ Skipped bad chunk: $e');
              }
            }
          },
          onError: (error) {
            if (!completer.isCompleted) {
              debugPrint('🔴 Stream error: $error');
              completer.complete(
                buffer.isNotEmpty ? buffer.toString() : 'Error: $error',
              );
            }
            _client?.close();
          },
          onDone: () {
            if (!completer.isCompleted) {
              debugPrint('✅ Stream done. Completing with buffered content.');
              completer.complete(buffer.toString());
            }
            _client?.close();
          },
          cancelOnError: true,
        );

    return completer.future;
  }
}
