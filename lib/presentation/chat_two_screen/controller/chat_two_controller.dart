import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/chat_two_screen/models/chat_two_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the ChatTwoScreen.
///
/// This class manages the state of the ChatTwoScreen, including the
/// current chatTwoModelObj
class ChatTwoController extends GetxController {
  TextEditingController messageOneController = TextEditingController();

  TextEditingController messageController = TextEditingController();

  Rx<ChatTwoModel> chatTwoModelObj = ChatTwoModel().obs;

  @override
  void onClose() {
    super.onClose();
    messageOneController.dispose();
    messageController.dispose();
  }
}
