import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/terms_and_conditions_screen/models/terms_and_conditions_model.dart';

/// A controller class for the TermsAndConditionsScreen.
///
/// This class manages the state of the TermsAndConditionsScreen, including the
/// current termsAndConditionsModelObj
class TermsAndConditionsController extends GetxController {
  Rx<TermsAndConditionsModel> termsAndConditionsModelObj =
      TermsAndConditionsModel().obs;
}
