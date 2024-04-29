import '../../../core/app_export.dart';
import 'frame_item_model.dart';

/// This class defines the variables used in the [question_two_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class QuestionTwoModel {
  Rx<List<FrameItemModel>> frameItemList = Rx([
    FrameItemModel(
        genderText: "Male".obs,
        genderImage: ImageConstant.imgCheckmarkPrimary.obs),
    FrameItemModel(genderText: "Female".obs),
    FrameItemModel(genderText: "Other".obs)
  ]);
}
