import '../controller/profile_four_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ProfileFourScreen.
///
/// This class ensures that the ProfileFourController is created when the
/// ProfileFourScreen is first loaded.
class ProfileFourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileFourController());
  }
}
