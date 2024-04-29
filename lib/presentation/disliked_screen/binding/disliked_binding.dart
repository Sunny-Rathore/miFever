import '../controller/disliked_controller.dart';
import 'package:get/get.dart';

/// A binding class for the DislikedScreen.
///
/// This class ensures that the DislikedController is created when the
/// DislikedScreen is first loaded.
class DislikedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DislikedController());
  }
}
