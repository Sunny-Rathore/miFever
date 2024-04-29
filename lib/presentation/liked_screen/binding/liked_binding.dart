import '../controller/liked_controller.dart';
import 'package:get/get.dart';

/// A binding class for the LikedScreen.
///
/// This class ensures that the LikedController is created when the
/// LikedScreen is first loaded.
class LikedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LikedController());
  }
}
