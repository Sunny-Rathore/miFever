import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

class HelpAndSupportController extends GetxController {
  TextEditingController helpController = TextEditingController();
  Rx<String> radioGroup = "".obs;
  Rx<SelectionPopupModel> selectedReason =
      SelectionPopupModel(title: 'Account Issues', value: 'Account Issues').obs;
}
