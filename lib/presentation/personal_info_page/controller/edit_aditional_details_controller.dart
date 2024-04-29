import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

class EditAdditionalDetailsController extends GetxController {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController religionController = TextEditingController();

  final TextEditingController heightInFeetController = TextEditingController();
  final TextEditingController heightInInchController = TextEditingController();

  var selectedHonoscope = 'lbl_aries'.tr.obs;
  var selectedDrinkingStatus = 'lbl_drinker'.tr.obs;
  var selectedSmokingStatus = 'lbl_smoking'.tr.obs;
  //var selectedReligion = 'lbl_christianity'.tr.obs;
  var selectedChildrenStatus = 'lbl_yes'.tr.obs;
  var selectedHairColor = 'lbl_brown'.tr.obs;
  var selectedMusicPreference = 'lbl_pop'.tr.obs;
  var selectedMartialStatus = 'lbl_single'.tr.obs;
  var selectedHeightUnit = 'CM'.tr.obs;

  List honoscope = [
    'lbl_aries'.tr,
    'lbl_taurus'.tr,
    'lbl_gemini'.tr,
    'lbl_cancer'.tr,
    'lbl_leo'.tr,
    'lbl_virgo'.tr,
    'lbl_libra'.tr,
    'lbl_scorpio'.tr,
    'lbl_sagittarius'.tr,
    'lbl_capricorn'.tr,
    'lbl_aquarius'.tr,
    'lbl_pisces'.tr,
  ];
  List drinkingStatus = [
    'lbl_drinker'.tr,
    'lbl_nondrinker'.tr,
    'lbl_socialdrinker'.tr
  ];
  List smokingStatus = [
    'lbl_smoking'.tr,
    'lbl_nonsmoking'.tr,
    'lbl_socialsmoking'.tr
  ];
  List religion = [
    'lbl_christianity'.tr,
    'lbl_islam'.tr,
    'lbl_judaism'.tr,
    'lbl_hinduism'.tr,
    'lbl_buddhism'.tr,
    'lbl_sikhism'.tr,
    'lbl_jainism'.tr,
    'lbl_other'.tr
  ];
  List childrenStatus = [
    'lbl_yes'.tr,
    'lbl_no'.tr,
    'lbl_someday'.tr,
  ];
  List hairColor = [
    'lbl_brown'.tr,
    'lbl_black'.tr,
    'lbl_blonde'.tr,
    'lbl_red'.tr,
    'lbl_other'.tr
  ];
  List musicPreference = [
    'lbl_hiphoprap'.tr,
    'lbl_electronicdance'.tr,
    'lbl_classical'.tr,
    'lbl_jazz'.tr,
    'lbl_country'.tr,
    'lbl_metal'.tr,
    'lbl_rbsoul'.tr,
    'lbl_alternative'.tr,
    'lbl_indie'.tr,
    'lbl_folk'.tr,
    'lbl_reggae'.tr,
    'lbl_othermusic'.tr,
  ];
  List martialStatus = [
    'lbl_single'.tr,
    'lbl_married'.tr,
    'lbl_divorced'.tr,
    'lbl_widowed'.tr,
    'lbl_separated'.tr,
  ];
}
