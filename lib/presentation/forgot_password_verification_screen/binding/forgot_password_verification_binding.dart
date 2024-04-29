import '../controller/forgot_password_verification_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ForgotPasswordVerificationScreen.
///
/// This class ensures that the ForgotPasswordVerificationController is created when the
/// ForgotPasswordVerificationScreen is first loaded.
class ForgotPasswordVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordVerificationController());
  }
}
