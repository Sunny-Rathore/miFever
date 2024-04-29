import '../controller/chat_two_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ChatTwoScreen.
///
/// This class ensures that the ChatTwoController is created when the
/// ChatTwoScreen is first loaded.
class ChatTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatTwoController());
  }
}
