import '../controller/forgot_password_verification_one_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ForgotPasswordVerificationOneScreen.
///
/// This class ensures that the ForgotPasswordVerificationOneController is created when the
/// ForgotPasswordVerificationOneScreen is first loaded.
class ForgotPasswordVerificationOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordVerificationOneController());
  }
}
