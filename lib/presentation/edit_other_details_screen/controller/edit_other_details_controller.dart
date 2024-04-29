import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/presentation/edit_other_details_screen/models/edit_other_details_model.dart';

import '../../../data/sevices/firebase_services.dart';

class EditOtherDetailsController extends GetxController {
  TextEditingController cityController = TextEditingController();

  TextEditingController countryController = TextEditingController();

  Rx<EditOtherDetailsModel> editOtherDetailsModelObj =
      EditOtherDetailsModel().obs;

  ///var locationControllerCityControllerList = <TextEditingController>[].obs;
  var availableLocationControllerList = <TextEditingController>[].obs;

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
      availableLocation: getLocation(),
      // availableCity: getCity(),
      // availableCountry: getCountry(),
    );
    await FirebaseServices.updateUser(_userModel);
    ProgressDialogUtils.hideProgressDialog();
    Get.back();
  }

  List getLocation() {
    List _location = [];

    for (var location in availableLocationControllerList) {
      _location.add(location.text);
    }
    return _location;
  }

  @override
  void onInit() {
    FirebaseServices.getCurrentUser().then((user) {
      if (user != null) {
        selectedInterest.clear();
        selectedInterest.addAll(user.interestList ?? []);
        whatDoYouWantToFindOut.value = user.whatDoYouWant ?? '';

        for (var i = 0; i < user.availableLocation!.length; i++) {
          availableLocationControllerList.add(TextEditingController());

          availableLocationControllerList[i].text =
              user.availableLocation?[i] ?? '';
        }
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
