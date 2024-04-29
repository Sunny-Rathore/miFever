import '../controller/create_new_password_two_controller.dart';
import 'package:get/get.dart';

/// A binding class for the CreateNewPasswordTwoScreen.
///
/// This class ensures that the CreateNewPasswordTwoController is created when the
/// CreateNewPasswordTwoScreen is first loaded.
class CreateNewPasswordTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateNewPasswordTwoController());
  }
}
