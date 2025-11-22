import 'package:easy_chat/models/chat_message.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../objectbox.g.dart';

class MessagesBox {
  /// The Store of this app.
  static late final Store _store;

  // MessagesBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  // }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<void> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    _store = await openStore(directory: p.join(docsDir.path, "pending_chat_messages"));
  }

  static Box<ChatMessages> get _getMessagesBox => _store.box<ChatMessages>();

  static List<ChatMessages> getAllOfflineMessages() => _getMessagesBox.getAll();

  static void put(ChatMessages msg) => _getMessagesBox.put(msg);

  static void remove(int id) => _getMessagesBox.remove(id);

  static void clear() => _getMessagesBox.removeAll();

}