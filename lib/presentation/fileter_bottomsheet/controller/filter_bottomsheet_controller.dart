import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/presentation/fileter_bottomsheet/models/fileter_bottomsheet_model.dart';
import 'package:mifever/presentation/home_screen/controller/home_controller.dart';
import 'package:mifever/widgets/custom_bottom_bar.dart';

import '../../../data/models/filter/filter_model.dart';
import '../../../data/sevices/google_places_services.dart';
import '../filter_bottomsheet.dart';

class FilterBottomSheetController extends GetxController {
  TextEditingController locationController = TextEditingController();
  TextEditingController religionController = TextEditingController();

  Rx<GeoPoint> locationLatLong = GeoPoint(0.0, 0.0).obs;

  RxDouble distanceSliderValue = 0.0.obs;

  Rx<RangeValues> ageRange = Rx(RangeValues(0.0, 0.0));

  Rx<RangeValues> heightRange = Rx(RangeValues(100.0, 200.0));

  Rx<RangeValues> heightRangeFeet = Rx(RangeValues(4.0, 7.0));

  var isHeightFilterApplied = false.obs;

  RxString selectedInterest = 'Male'.obs;

  RxString selectedHoroscope = ''.tr.obs;

  var selectedDrinkingStatus = ''.tr.obs;

  var selectedSmokingStatus = ''.tr.obs;

  //var selectedReligion = ''.tr.obs;

  var selectedChildrenStatus = ''.tr.obs;

  var selectedHairColor = ''.tr.obs;

  var selectedMusicPreference = ''.tr.obs;

  var selectedMartialStatus = ''.tr.obs;

  var selectedHeightUnit = ''.tr.obs;

  var isExpanded = false.obs;

  Rx<ActivePlanModel> activePlanModelObj = ActivePlanModel().obs;

  SelectionPopupModel? selectedDropDownValue;

  SelectionPopupModel? selectedDropDownValue1;

  var isSoutheastAsianCountries =
      southeastAsianCountries.contains(PrefUtils.getCountry()).obs;
  onSelected(dynamic value) {
    for (var element in activePlanModelObj.value.dropdownItemList.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    activePlanModelObj.value.dropdownItemList.refresh();
  }

  onSelected1(dynamic value) {
    for (var element in activePlanModelObj.value.dropdownItemList1.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    activePlanModelObj.value.dropdownItemList1.refresh();
  }

  onApply() async {
    print(
        'location==> latitude==>${locationLatLong.value.latitude} longitude==> ${locationLatLong.value.longitude}');
    print("==>" +
        southeastAsianCountries.contains(PrefUtils.getCountry()).toString());
    ProgressDialogUtils.showProgressDialog();
    PreferenceFilter filter = PreferenceFilter(
      isHeightFilterApplied: isHeightFilterApplied.value,
      country: locationController.text,
      city: '',
      distance: distanceSliderValue.value,
      ageRangeStart: ageRange.value.start,
      ageRangeEnd: ageRange.value.end,
      interestedIn: selectedInterest.value,
      locationText: locationController.text,
      lat: locationLatLong.value.latitude,
      lng: locationLatLong.value.longitude,
      childrenStatus: selectedChildrenStatus.value,
      drinkingStatus: selectedDrinkingStatus.value,
      hairColor: selectedHairColor.value,
      heightEnd: selectedHeightUnit.value == 'CM'
          ? heightRange.value.end
          : heightRange.value.end * 30.48,
      heightStart: selectedHeightUnit.value == 'CM'
          ? heightRange.value.start
          : heightRange.value.start * 30.48,
      horoscope: selectedHoroscope.value,
      maritalStatus: selectedMartialStatus.value,
      musicPreference: selectedMusicPreference.value,
      religion: religionController.text,
      smokingStatus: selectedSmokingStatus.value,
    );

    PrefUtils.saveFilter(filter);

    final homeController = Get.find<HomeController>();

    homeController.getUsersFiltered(
      minAge: ageRange.value.start.round(),
      maxAge: ageRange.value.end.round(),
      maxDistance: distanceSliderValue.value,
      gender: selectedInterest.value,
      currentUserLocation: locationLatLong.value,
      filter: filter,
    );
    ProgressDialogUtils.hideProgressDialog();
    Get.offAll(() => CustomBottomBar());
  }

  onCancelAll() async {
    await GooglePlacesApiServices.getLatLongFromAddress(
            PrefUtils.getAvailableLocation())
        .then((value) => locationLatLong.value = value);

    isHeightFilterApplied.value = false;
    selectedChildrenStatus.value = '';
    selectedDrinkingStatus.value = '';
    selectedHairColor.value = '';
    heightRange.value = RangeValues(100.0, 200.0);
    selectedHoroscope.value = '';
    selectedMartialStatus.value = '';
    selectedMusicPreference.value = '';
    religionController.text = '';
    selectedSmokingStatus.value = '';
    distanceSliderValue.value = 10.0;
    selectedInterest.value = getOppositeGender(PrefUtils.getUserGender());
    ageRange.value = isSoutheastAsianCountries.value
        ? RangeValues(21.0, 40.0)
        : RangeValues(18.0, 40.0);
    locationLatLong.value = locationLatLong.value;
    //GeoPoint(20.4481338, 82.7462439);
    locationController.text = PrefUtils.getAvailableLocation();
    // 'Roman Catholic';
    ProgressDialogUtils.showProgressDialog();
    PreferenceFilter filter = PreferenceFilter(
      isHeightFilterApplied: isHeightFilterApplied.value,
      country: locationController.text,
      city: '',
      distance: distanceSliderValue.value,
      ageRangeStart: ageRange.value.start,
      ageRangeEnd: ageRange.value.end,
      interestedIn: selectedInterest.value,
      locationText: locationController.text,
      lat: locationLatLong.value.latitude,
      lng: locationLatLong.value.longitude,
      childrenStatus: selectedChildrenStatus.value,
      drinkingStatus: selectedDrinkingStatus.value,
      hairColor: selectedHairColor.value,
      heightEnd: heightRange.value.end,
      heightStart: heightRange.value.start,
      horoscope: selectedHoroscope.value,
      maritalStatus: selectedMartialStatus.value,
      musicPreference: selectedMusicPreference.value,
      religion: religionController.text,
      smokingStatus: selectedSmokingStatus.value,
    );

    PrefUtils.saveFilter(filter);

    final homeController = Get.find<HomeController>();

    homeController.getUsersFiltered(
        minAge: ageRange.value.start.round(),
        maxAge: ageRange.value.end.round(),
        maxDistance: distanceSliderValue.value,
        gender: selectedInterest.value,
        currentUserLocation: locationLatLong.value,
        filter: filter);
    ProgressDialogUtils.hideProgressDialog();
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    print('location==>${PrefUtils.getAvailableLocation()}');
    GooglePlacesApiServices.getLatLongFromAddress(
            PrefUtils.getAvailableLocation())
        .then((value) => locationLatLong.value = value);
    PrefUtils.getFilter().then((filter) {
      if (filter != null) {
        distanceSliderValue.value = filter.distance;
        ageRange.value = RangeValues(filter.ageRangeStart, filter.ageRangeEnd);
        selectedInterest.value = filter.interestedIn;
        locationController.text = filter.locationText;
        locationLatLong.value = GeoPoint(filter.lat, filter.lng);
        selectedChildrenStatus.value = filter.childrenStatus;
        selectedDrinkingStatus.value = filter.drinkingStatus;
        selectedHairColor.value = filter.hairColor;
        heightRange.value = RangeValues(filter.heightStart, filter.heightEnd);
        heightRangeFeet.value =
            RangeValues(filter.heightStart * 30.48, filter.heightEnd * 30.48);
        selectedHoroscope.value = filter.horoscope;
        selectedMartialStatus.value = filter.maritalStatus;
        selectedMusicPreference.value = filter.musicPreference;
        religionController.text = filter.religion;
        selectedSmokingStatus.value = filter.smokingStatus;
      } else {
        distanceSliderValue.value = 10.0;
        selectedInterest.value = getOppositeGender(PrefUtils.getUserGender());
        ageRange.value = isSoutheastAsianCountries.value
            ? RangeValues(21.0, 40.0)
            : RangeValues(18.0, 40.0);
        heightRange.value = RangeValues(100.0, 200.0);
        locationLatLong.value = locationLatLong.value;
        //GeoPoint(20.4481338, 82.7462439);
        locationController.text = PrefUtils.getAvailableLocation();
        //"Roman Catholic";
      }
    });
  }

  String getOppositeGender(String gender) {
    if (gender == 'Male') {
      return 'Female';
    } else if (gender == 'Female') {
      return 'Male';
    } else {
      return 'Other';
    }
  }
}
