import '../controller/my_profile_two_controller.dart';
import 'package:get/get.dart';

/// A binding class for the MyProfileTwoScreen.
///
/// This class ensures that the MyProfileTwoController is created when the
/// MyProfileTwoScreen is first loaded.
class MyProfileTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyProfileTwoController());
  }
}
