import 'package:flutter/foundation.dart';
import '../models/message.dart';
import '../services/storage_service.dart';
import '../services/api_service.dart';

class ChatController extends ChangeNotifier {
  final ApiService apiService;
  final StorageService storageService;

  ChatController({required this.apiService, required this.storageService});

  final List<Message> _messages = [];
  List<Message> get messages => List.unmodifiable(_messages);

  Future<void> init() async {
    await storageService.init();
    _messages.clear();
    _messages.addAll(storageService.fetchAll());
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    _append(text, isUser: true);
    _append('...', isUser: false, persist: false);

    try {
      final reply = await apiService.streamChat(text);
      _replaceLast(reply);
    } catch (e) {
      _replaceLast('Error: $e');
    }
  }

  void cancelStream() => apiService.cancel();

  Future<void> clearChat() async {
    _messages.clear();
    await storageService.clear();
    notifyListeners();
  }

  void _append(String text, {required bool isUser, bool persist = true}) {
    final msg = Message(
      id: DateTime.now().toIso8601String(),
      text: text,
      isUser: isUser,
    );
    _messages.add(msg);
    if (persist) storageService.add(text, isUser);
    notifyListeners();
  }

  void _replaceLast(String text) {
    if (_messages.isEmpty) return;

    final last = _messages.removeLast();
    final updated = Message(id: last.id, text: text, isUser: false);
    _messages.add(updated);

    storageService.clear();
    for (final m in _messages) {
      storageService.add(m.text, m.isUser);
    }

    notifyListeners();
  }
}
