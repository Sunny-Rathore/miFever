import '../../../core/app_export.dart';

/// This class defines the variables used in the [block_proflie_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class BlockProflieModel {
  Rx<List<String>> radioList = Rx([
    "msg_suspicious_activity".tr,
    "lbl_potential_scam".tr,
    "msg_inappropriate_behavior".tr,
    "lbl_other".tr
  ]);
}
