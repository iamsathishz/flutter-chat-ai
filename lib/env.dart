import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static late String openrouterKey;
  static late String hfToken;

  static Future<void> load() async {
    await dotenv.load();
    openrouterKey = dotenv.env['OPENROUTER_API_KEY'] ?? '';
    hfToken = dotenv.env['HF_TOKEN'] ?? '';
  }
}
