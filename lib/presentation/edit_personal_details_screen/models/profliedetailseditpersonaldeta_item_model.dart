import '../../../core/app_export.dart';

/// This class is used in the [profliedetailseditpersonaldeta_item_widget] screen.
class ProfliedetailseditpersonaldetaItemModel {
  ProfliedetailseditpersonaldetaItemModel({
    this.id,
    this.title,
    this.isSelected,
  }) {
    id = id ?? Rx("");
    title = title ?? Rx("Male");
    isSelected = isSelected ?? Rx(false);
  }

  Rx<String>? id;

  Rx<String>? title;

  Rx<bool>? isSelected;
}
