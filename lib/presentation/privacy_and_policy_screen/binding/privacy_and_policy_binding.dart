import '../controller/privacy_and_policy_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PrivacyAndPolicyScreen.
///
/// This class ensures that the PrivacyAndPolicyController is created when the
/// PrivacyAndPolicyScreen is first loaded.
class PrivacyAndPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyAndPolicyController());
  }
}
