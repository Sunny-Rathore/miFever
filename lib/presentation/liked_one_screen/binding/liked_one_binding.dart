import '../controller/liked_one_controller.dart';
import 'package:get/get.dart';

/// A binding class for the LikedOneScreen.
///
/// This class ensures that the LikedOneController is created when the
/// LikedOneScreen is first loaded.
class LikedOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LikedOneController());
  }
}
