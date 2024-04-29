import '../../../core/app_export.dart';

/// This class is used in the [chipview_item_widget] screen.
class ChipviewItemModel {
  Rx<String>? playlist = Rx("Movie");
  Rx<String>? playlistImg = Rx("");

  Rx<bool>? isSelected = Rx(false);
}
