import 'package:get/get.dart';

import '../controller/help_and_support_controller.dart';

/// A binding class for the PrivacyAndPolicyOneScreen.
///
/// This class ensures that the PrivacyAndPolicyOneController is created when the
/// PrivacyAndPolicyOneScreen is first loaded.
class HelpAndSupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HelpAndSupportController());
  }
}
