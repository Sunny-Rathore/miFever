import '../controller/delete_chat_controller.dart';
import 'package:get/get.dart';

/// A binding class for the DeleteChatScreen.
///
/// This class ensures that the DeleteChatController is created when the
/// DeleteChatScreen is first loaded.
class DeleteChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeleteChatController());
  }
}
