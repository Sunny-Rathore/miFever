import '../../../core/app_export.dart';

/// This class is used in the [frame_item_widget] screen.
class FrameItemModel {
  FrameItemModel({
    this.genderText,
    this.genderImage,
    this.id,
  }) {
    genderText = genderText ?? Rx("Male");
    genderImage = genderImage ?? Rx(ImageConstant.imgCheckmarkPrimary);
    id = id ?? Rx("");
  }

  Rx<String>? genderText;

  Rx<String>? genderImage;

  Rx<String>? id;
}
