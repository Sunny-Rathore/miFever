import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/block_proflie_screen/models/block_proflie_model.dart';

class BlockProflieController extends GetxController {
  TextEditingController otherController = TextEditingController();

  TextEditingController optionalController = TextEditingController();

  Rx<BlockProflieModel> blockProflieModelObj = BlockProflieModel().obs;

  Rx<String> selectReasonWhyYouWantToBlockJ = "".obs;

  @override
  void onClose() {
    super.onClose();
    otherController.dispose();
    optionalController.dispose();
  }
}
