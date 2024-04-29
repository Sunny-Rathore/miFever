import 'package:mifever/core/app_export.dart';import 'package:mifever/presentation/filter_one_bottomsheet/models/filter_one_model.dart';import 'package:flutter/material.dart';/// A controller class for the FilterOneBottomsheet.
///
/// This class manages the state of the FilterOneBottomsheet, including the
/// current filterOneModelObj
class FilterOneController extends GetxController {TextEditingController countryController = TextEditingController();

Rx<FilterOneModel> filterOneModelObj = FilterOneModel().obs;

SelectionPopupModel? selectedDropDownValue;

@override void onClose() { super.onClose(); countryController.dispose(); } 
onSelected(dynamic value) { for (var element in filterOneModelObj.value.dropdownItemList.value) {element.isSelected = false; if (element.id == value.id) {element.isSelected = true;}} filterOneModelObj.value.dropdownItemList.refresh(); } 
 }
