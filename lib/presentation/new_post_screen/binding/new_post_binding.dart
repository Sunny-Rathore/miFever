import '../controller/new_post_controller.dart';
import 'package:get/get.dart';

/// A binding class for the NewPostScreen.
///
/// This class ensures that the NewPostController is created when the
/// NewPostScreen is first loaded.
class NewPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewPostController());
  }
}
