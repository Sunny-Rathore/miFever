import '../../../core/app_export.dart';

/// This class defines the variables used in the [proflie_details_edit_other_details_screen],
import 'frame10_item_model.dart';

class EditOtherDetailsModel {
  static List palyList = [
    'Movie',
    'Gaming',
    'Nature',
    'Photography',
    'Gym & Fitness',
    'Sports',
    'Design',
    'Dancing',
    'Reading',
    'Music',
    'Writing',
    'Cooking',
    'Animals',
  ];
  Rx<List<OtherDetailsItemWidgetModel>> chipviewItemList = Rx(List.generate(
      palyList.length,
      (index) =>
          OtherDetailsItemWidgetModel()..playlist = Rx(palyList[index])));

  Rx<List<String>> radioList = Rx([
    "lbl_casual_dating".tr,
    "msg_serious_relationship".tr,
    "msg_culture_learning".tr,
    "lbl_i_don_t_know".tr,
  ]);
}
