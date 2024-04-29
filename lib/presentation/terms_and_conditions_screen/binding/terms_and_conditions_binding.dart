import '../controller/terms_and_conditions_controller.dart';
import 'package:get/get.dart';

/// A binding class for the TermsAndConditionsScreen.
///
/// This class ensures that the TermsAndConditionsController is created when the
/// TermsAndConditionsScreen is first loaded.
class TermsAndConditionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsAndConditionsController());
  }
}
