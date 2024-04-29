import 'package:mifever/core/app_export.dart';import 'package:mifever/presentation/profile_one_screen/models/profile_one_model.dart';import 'package:flutter/material.dart';/// A controller class for the ProfileOneScreen.
///
/// This class manages the state of the ProfileOneScreen, including the
/// current profileOneModelObj
class ProfileOneController extends GetxController {TextEditingController messageController = TextEditingController();

Rx<ProfileOneModel> profileOneModelObj = ProfileOneModel().obs;

Rx<int> sliderIndex = 0.obs;

@override void onClose() { super.onClose(); messageController.dispose(); } 
 }
