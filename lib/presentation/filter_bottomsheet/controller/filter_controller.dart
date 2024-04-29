import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/filter_bottomsheet/models/filter_model.dart';

/// A controller class for the FilterBottomsheet.
///
/// This class manages the state of the FilterBottomsheet, including the
/// current filterModelObj
class FilterController extends GetxController {
  Rx<FilterModel> filterModelObj = FilterModel().obs;

  RxDouble sliderValue = 0.0.obs;

  SelectionPopupModel? selectedDropDownValue;

  SelectionPopupModel? selectedDropDownValue1;

  onSelected(dynamic value) {
    for (var element in filterModelObj.value.dropdownItemList.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    filterModelObj.value.dropdownItemList.refresh();
  }

  onSelected1(dynamic value) {
    for (var element in filterModelObj.value.dropdownItemList1.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    filterModelObj.value.dropdownItemList1.refresh();
  }
}
