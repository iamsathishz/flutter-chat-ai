import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/message.dart';

class StorageService {
  late Box<Message> _box;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(MessageAdapter());
    }
    _box = await Hive.openBox<Message>('messages');
  }

  List<Message> fetchAll() {
    return _box.values.where((msg) => msg.text.trim() != '...').toList();
  }

  Future<void> add(String text, bool isUser) async {
    final message = Message(id: const Uuid().v4(), text: text, isUser: isUser);
    await _box.add(message);
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
