import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/travel_plan/travel_plan_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/create_travel_plan_screen/models/create_travel_plan_model.dart';

/// A controller class for the CreateTravelPlanScreen.
///
/// This class manages the state of the CreateTravelPlanScreen, including the
/// current createTravelPlanModelObj
class CreateTravelPlanController extends GetxController {
  TextEditingController nameController = TextEditingController();

  TextEditingController countryController = TextEditingController();

  Rx<CreateTravelPlanModel> createTravelPlanModelObj =
      CreateTravelPlanModel().obs;
  Rx<DateTime> initialDateTime = DateTime.now().add(Duration(days: 1)).obs;
  Rx<GeoPoint> locationLatLong = GeoPoint(0, 0).obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  //'msg_select_your_travel'.tr.obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  // 'msg_select_your_travel2'.tr.obs;
  var docId = ''.obs;
  void addPlan() async {
    ProgressDialogUtils.showProgressDialog();
    TravelPlanModel travelPlanModel = TravelPlanModel(
        userId: PrefUtils.getId(),
        planName: nameController.text.trim(),
        startDate: startDate.value.toString(),
        endDate: endDate.value.toString(),
        location: countryController.text,
        latLng: locationLatLong.value,
        isActive: true);
    if (docId.value.isEmpty) {
      await FirebaseServices.addTravelPlan(travelPlanModel);
      Get.back();
      clearValues();
    } else {
      await FirebaseServices.updateTravelPlan(
          travelPlanModel: travelPlanModel, docId: docId.value);
      clearValues();
      Get.back();
    }
    ProgressDialogUtils.hideProgressDialog();
  }

  void clearValues() {
    nameController.clear();
    startDate.value = DateTime.now();
    endDate.value = DateTime.now();
    countryController.clear();
    docId.value = '';
    locationLatLong.value = GeoPoint(0, 0);
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    countryController.dispose();
  }
}
