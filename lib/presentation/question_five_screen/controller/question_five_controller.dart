import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/question_five_screen/models/question_five_model.dart';

class QuestionFiveController extends GetxController {
  TextEditingController locationTextController = TextEditingController();

  Rx<QuestionFiveModel> questionFiveModelObj = QuestionFiveModel().obs;
  Rx<GeoPoint> locationLatLong = GeoPoint(0.0, 0.0).obs;
  RxBool isButtonDisable = RxBool(true);
  List<LocationModel> locationList = <LocationModel>[
    LocationModel(
        name: 'Location1',
        latLng: GeoPoint(0.0, 0.0),
        locationName: 'lbl_enter_location'.tr)
  ].obs;

  // var locationLength = 1.obs;
  bool isMakeButtonDisable() {
    if (locationTextController.text.trim().isEmpty ||
        locationList.firstWhereOrNull(
                (element) => element.locationName == 'lbl_enter_location'.tr) !=
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

class LocationModel {
  final String name;
  final GeoPoint latLng;
  final String locationName;

  LocationModel(
      {required this.name, required this.latLng, required this.locationName});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        name: json['name'],
        latLng: json['latLng'],
        locationName: json['locationName'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'latLng': latLng,
        'locationName': locationName,
      };
}
