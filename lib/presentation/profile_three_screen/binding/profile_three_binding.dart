import '../controller/profile_three_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ProfileThreeScreen.
///
/// This class ensures that the ProfileThreeController is created when the
/// ProfileThreeScreen is first loaded.
class ProfileThreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileThreeController());
  }
}
