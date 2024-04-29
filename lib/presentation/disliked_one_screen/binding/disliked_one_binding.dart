import '../controller/disliked_one_controller.dart';
import 'package:get/get.dart';

/// A binding class for the DislikedOneScreen.
///
/// This class ensures that the DislikedOneController is created when the
/// DislikedOneScreen is first loaded.
class DislikedOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DislikedOneController());
  }
}
