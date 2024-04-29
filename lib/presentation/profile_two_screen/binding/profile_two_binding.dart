import '../controller/profile_two_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ProfileTwoScreen.
///
/// This class ensures that the ProfileTwoController is created when the
/// ProfileTwoScreen is first loaded.
class ProfileTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileTwoController());
  }
}
