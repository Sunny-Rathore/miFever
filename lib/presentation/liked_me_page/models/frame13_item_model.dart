import '../../../core/app_export.dart';

/// This class is used in the [frame13_item_widget] screen.
class Frame13ItemModel {
  Frame13ItemModel({
    this.dynamicText,
    this.dynamicText1,
    this.id,
  }) {
    dynamicText = dynamicText ?? Rx("122");
    dynamicText1 = dynamicText1 ?? Rx("Liked Profile");
    id = id ?? Rx("");
  }

  Rx<String>? dynamicText;

  Rx<String>? dynamicText1;

  Rx<String>? id;
}
