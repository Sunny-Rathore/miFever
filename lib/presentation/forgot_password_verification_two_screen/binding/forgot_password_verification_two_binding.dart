import '../controller/forgot_password_verification_two_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ForgotPasswordVerificationTwoScreen.
///
/// This class ensures that the ForgotPasswordVerificationTwoController is created when the
/// ForgotPasswordVerificationTwoScreen is first loaded.
class ForgotPasswordVerificationTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordVerificationTwoController());
  }
}
