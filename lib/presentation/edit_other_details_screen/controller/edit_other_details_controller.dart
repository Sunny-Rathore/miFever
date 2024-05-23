import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/presentation/edit_other_details_screen/models/edit_other_details_model.dart';

import '../../../data/sevices/firebase_services.dart';
import '../../question_five_screen/controller/question_five_controller.dart';

class EditOtherDetailsController extends GetxController {
  TextEditingController cityController = TextEditingController();

  TextEditingController countryController = TextEditingController();

  Rx<EditOtherDetailsModel> editOtherDetailsModelObj =
      EditOtherDetailsModel().obs;

  List<LocationModel> availableLocation = <LocationModel>[].obs;
  Rx<String> whatDoYouWantToFindOut = "lbl_casual_dating".tr.obs;

  List selectedInterest = [].obs;

  var isButtonDisable = false.obs;

  List palyList = [
    'Movie',
    'Gaming',
    'Nature',
    'Photography',
    'Gym & Fitness',
    'Sports',
    'Design',
    'Dancing',
    'Reading',
    'Music',
    'Writing',
    'Cooking',
    'Animals',
  ];

  void onTapSave() async {
    ProgressDialogUtils.showProgressDialog();
    UserModel _userModel = UserModel(
      interestList: selectedInterest,
      whatDoYouWant: whatDoYouWantToFindOut.value,
      availableLocation: availableLocation,
    );
    await FirebaseServices.updateUser(_userModel);
    ProgressDialogUtils.hideProgressDialog();
    Get.back();
  }

  @override
  void onInit() {
    FirebaseServices.getCurrentUser().then((user) {
      if (user != null) {
        selectedInterest.clear();
        selectedInterest.addAll(user.interestList ?? []);
        whatDoYouWantToFindOut.value = user.whatDoYouWant ?? '';
        availableLocation.assignAll(user.availableLocation!);
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    cityController.dispose();
    countryController.dispose();
  }
}
