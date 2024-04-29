import '../controller/create_a_password_controller.dart';
import 'package:get/get.dart';

/// A binding class for the CreateAPasswordScreen.
///
/// This class ensures that the CreateAPasswordController is created when the
/// CreateAPasswordScreen is first loaded.
class CreateAPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateAPasswordController());
  }
}
