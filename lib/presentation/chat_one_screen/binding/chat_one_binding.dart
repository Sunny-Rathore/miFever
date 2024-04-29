import '../controller/chat_one_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ChatOneScreen.
///
/// This class ensures that the ChatOneController is created when the
/// ChatOneScreen is first loaded.
class ChatOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatOneController());
  }
}
