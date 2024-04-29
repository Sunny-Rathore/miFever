import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/travel_plan/travel_plan_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/chat_screen/controller/chat_controller.dart';
import 'package:mifever/presentation/chat_screen/models/chat_model.dart';
import 'package:mifever/presentation/my_chats_one_page/models/my_chats_one_model.dart';

class MyChatsOneController extends GetxController {
  MyChatsOneController(this.myChatsOneModelObj);

  Rx<MyChatsOneModel> myChatsOneModelObj;
  final searchController = TextEditingController();
  var query = ''.obs;
  var isSelected = false.obs;
  var isSearch = false.obs;
  RxList selectedUser = [].obs;

  var isShowNoUserFound = false.obs;

  void onDeleteChat() async {
    ProgressDialogUtils.showProgressDialog();
    for (var userId in selectedUser) {
      await FirebaseServices.deleteChats(userId);
    }
    ProgressDialogUtils.hideProgressDialog();
    selectedUser.clear();
    isSelected.value = false;
  }

  void onSharePlan(TravelPlanModel model) async {
    ProgressDialogUtils.showProgressDialog();
    for (var userId in selectedUser) {
      ChatModel chatModel = ChatModel(
          roomId: FirebaseServices.createChatRoomId(userId),
          //message: messageController.text.trim(),
          senderId: PrefUtils.getId(),
          receiverId: userId,
          timestamp: DateTime.now().toString(),
          type: MessageType.Travel.name,
          linkCount: 0,
          isSeen: false,
          travelPlan: model);
      await FirebaseServices.sendMessage(chat: chatModel);
    }
    ProgressDialogUtils.hideProgressDialog();
    selectedUser.clear();
    isSelected.value = false;
    Get.back();
  }

  bool isVisible(String name) {
    if (query.value.isEmpty) {
      return true;
    }
    if (name.toLowerCase().contains(query.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

  clearSearchBar() {
    isSearch.value = false;
    query.value = "";
    searchController.clear();
  }
}
