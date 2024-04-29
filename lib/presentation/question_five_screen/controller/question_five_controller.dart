import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/question_five_screen/models/question_five_model.dart';

/// A controller class for the QuestionFiveScreen.
///
/// This class manages the state of the QuestionFiveScreen, including the
/// current questionFiveModelObj
class QuestionFiveController extends GetxController {
  TextEditingController locationTextController = TextEditingController();

  var availableLocationTextController =
      <TextEditingController>[TextEditingController()].obs;
  Rx<QuestionFiveModel> questionFiveModelObj = QuestionFiveModel().obs;

  RxBool isButtonDisable = RxBool(true);

  var locationLength = 1.obs;
  bool isMakeButtonDisable() {
    print(availableLocationTextController
            .firstWhereOrNull((element) => element.text.isEmpty) !=
        null);
    if (locationTextController.text.trim().isEmpty ||
        availableLocationTextController
                .firstWhereOrNull((element) => element.text.isEmpty) !=
            null) {
      isButtonDisable.value = true;
      return true;
    }
    isButtonDisable.value = false;
    return false;
  }

  @override
  void onClose() {
    super.onClose();
    locationTextController.dispose();
  }
}
