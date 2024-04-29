// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifever/core/app_export.dart';

import '../../../core/utils/progress_dialog_utils.dart';
import '../../../data/models/user/adiition_details.dart';
import '../../../data/models/user/user_model.dart';
import '../../../data/sevices/firebase_services.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_subtitle.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../controller/edit_aditional_details_controller.dart';

class EditAdditionalDetailsPage extends StatelessWidget {
  final String mapKey;
  final String value;
  final AdditionalPersonalInfo additionalPersonalInfo;
  EditAdditionalDetailsPage(
      {Key? key,
      required this.mapKey,
      required this.value,
      required this.additionalPersonalInfo})
      : super(key: key);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controller = Get.put(EditAdditionalDetailsController());
  @override
  Widget build(BuildContext context) {
    print('build $value');
    setValue(mapKey);
    return Scaffold(
      appBar: _buildAppBar(),
      body: SizedBox(
        width: SizeUtils.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 24.v,
                ),
                child: getWidget(mapKey)),
          ),
        ),
      ),
      bottomSheet: _buildFrame(),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Get.back();
        },
        imagePath: ImageConstant.imgArrowLeft02SharpGray90024x24,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 16.v,
          bottom: 16.v,
        ),
      ),
      title: AppbarSubtitle(
        text: "msg_edit_other_details".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildFrame() {
    return Padding(
        padding: EdgeInsets.only(
          left: 20.h,
          right: 20.h,
          bottom: 16.v,
        ),
        child: CustomElevatedButton(
          text: "lbl_save".tr,
          onPressed: _onTapContinue,
        ));
  }

  void _onTapContinue() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      if (controller.selectedHeightUnit.value != "CM") {
        convertFeetAndInchesToCm(
            int.parse(controller.heightInFeetController.text),
            int.parse(controller.heightInInchController.text));
      }
      print(controller.heightController.text);
      getOnSave(mapKey);
      //controller.onTapContinue();
    }
  }

  Widget _buildHeight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 23.v),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "lbl_height".tr,
              style: CustomTextStyles.titleSmallGray60004,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    controller.selectedHeightUnit.value = 'CM';
                  },
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: controller.selectedHeightUnit.value == 'CM'
                              ? appTheme.redA200
                              : appTheme.gray100,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          )),
                      child: Text(
                        'CM',
                        style: controller.selectedHeightUnit.value == 'CM'
                            ? CustomTextStyles.bodyMediumPrimary
                            : CustomTextStyles.bodyMediumGray900,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (controller.heightController.text.isNotEmpty) {
                      convertCmToFeetAndInches(
                          double.parse(controller.heightController.text));
                    }
                    controller.selectedHeightUnit.value = 'Ft/In';
                  },
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: controller.selectedHeightUnit.value != 'CM'
                              ? appTheme.redA200
                              : appTheme.gray200,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          )),
                      child: Text(
                        'Ft/In',
                        style: controller.selectedHeightUnit.value != 'CM'
                            ? CustomTextStyles.bodyMediumPrimary
                            : CustomTextStyles.bodyMediumGray900,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 8.v),
        Obx(() => controller.selectedHeightUnit.value == 'CM'
            ? CustomTextFormField(
                counter: Text(''),
                maxLength: 3,
                controller: controller.heightController,
                textInputType: TextInputType.number,
                hintText: "lbl_enter_your_height".tr,
                hintStyle: CustomTextStyles.bodySmall12,
                suffix: Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Text(
                    'CM',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                contentPadding: EdgeInsets.all(12.h),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.parse(value) < 100 ||
                      double.parse(value) > 300) {
                    return "err_msg_please_enter_valid_height".tr;
                  }
                  return null;
                },
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Feet'),
                        SizedBox(height: 3.v),
                        CustomTextFormField(
                          counter: Text(''),
                          maxLength: 1,
                          controller: controller.heightInFeetController,
                          textInputType: TextInputType.number,
                          hintText: "lbl_enter_your_height".tr,
                          hintStyle: CustomTextStyles.bodySmall12,
                          contentPadding: EdgeInsets.all(12.h),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                double.parse(value) < 1 ||
                                double.parse(value) > 9) {
                              return "err_msg_please_enter_valid_height".tr;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Inches'),
                        SizedBox(height: 3.v),
                        CustomTextFormField(
                          counter: Text(''),
                          maxLength: 2,
                          controller: controller.heightInInchController,
                          textInputType: TextInputType.number,
                          hintText: "lbl_enter_your_height".tr,
                          hintStyle: CustomTextStyles.bodySmall12,
                          contentPadding: EdgeInsets.all(12.h),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "err_msg_please_enter_valid_height".tr;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )),
      ],
    );
  }

  Widget _buildHonoscope() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 23.v),
        Text(
          "lbl_horoscope".tr,
          style: CustomTextStyles.titleSmallGray60004,
        ),
        SizedBox(height: 16.v),
        ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 12.v,
            );
          },
          itemCount: controller.honoscope.length,
          itemBuilder: (context, index) {
            return _buildSelectionWidget(
                controller.honoscope[index], controller.selectedHonoscope);
          },
        ),
        SizedBox(height: 123.v),
      ],
    );
  }

  Widget _buildSelectionWidget(String label, RxString selectedValue) {
    return Obx(
      () => InkWell(
        onTap: () {
          selectedValue.value = label;
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.h,
            vertical: 9.v,
          ),
          decoration: selectedValue.value == label
              ? AppDecoration.outlineRedA.copyWith(
                  border: Border.all(
                    color: appTheme.redA200,
                    width: 3.h,
                  ),
                  borderRadius: BorderRadiusStyle.roundedBorder4,
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(4.h),
                  border: Border.all(
                    color: appTheme.gray200,
                    width: 1.h,
                  ),
                ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 3.v),
                child: Obx(
                  () => Text(
                    label,
                    style: selectedValue.value == label
                        ? theme.textTheme.titleMedium
                        : CustomTextStyles.titleMediumGray900,
                  ),
                ),
              ),
              Obx(
                () => selectedValue.value == label
                    ? CustomImageView(
                        imagePath: ImageConstant.imgCheckmarkPrimary,
                        height: 20.adaptSize,
                        width: 20.adaptSize,
                      )
                    : Radio(value: false, groupValue: true, onChanged: null),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmokingWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 23.v),
        Text(
          "lbl_smokingOrNonSmoking".tr,
          style: CustomTextStyles.titleSmallGray60004,
        ),
        SizedBox(height: 16.v),
        ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 12.v,
            );
          },
          itemCount: controller.smokingStatus.length,
          itemBuilder: (context, index) {
            return _buildSelectionWidget(controller.smokingStatus[index],
                controller.selectedSmokingStatus);
          },
        ),
      ],
    );
  }

  Widget _buildDrinkStatusWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 23.v),
        Text(
          "lbl_drinkerOrNonDrinker".tr,
          style: CustomTextStyles.titleSmallGray60004,
        ),
        SizedBox(height: 16.v),
        ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 12.v,
            );
          },
          itemCount: controller.drinkingStatus.length,
          itemBuilder: (context, index) {
            return _buildSelectionWidget(controller.drinkingStatus[index],
                controller.selectedDrinkingStatus);
          },
        ),
      ],
    );
  }

  Widget _buildReligionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 23.v),
        Text(
          "lbl_religion".tr,
          style: CustomTextStyles.titleSmallGray60004,
        ),
        SizedBox(height: 16.v),
        CustomTextFormField(
          controller: controller.religionController,
          textInputType: TextInputType.name,
          hintText: "lbl_religion".tr,
          hintStyle: CustomTextStyles.bodySmall12,
          contentPadding: EdgeInsets.all(12.h),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "err_msg_please_enter_religion".tr;
            }
            return null;
          },
        )
        // ListView.separated(
        //   physics: BouncingScrollPhysics(),
        //   shrinkWrap: true,
        //   separatorBuilder: (
        //     context,
        //     index,
        //   ) {
        //     return SizedBox(
        //       height: 12.v,
        //     );
        //   },
        //   itemCount: controller.religion.length,
        //   itemBuilder: (context, index) {
        //     return _buildSelectionWidget(
        //         controller.religion[index], controller.selectedReligion);
        //   },
        // ),
      ],
    );
  }

  Widget _buildChildrenStatusWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 23.v),
        Text(
          "lbl_children".tr,
          style: CustomTextStyles.titleSmallGray60004,
        ),
        SizedBox(height: 16.v),
        ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 12.v,
            );
          },
          itemCount: controller.childrenStatus.length,
          itemBuilder: (context, index) {
            return _buildSelectionWidget(controller.childrenStatus[index],
                controller.selectedChildrenStatus);
          },
        ),
      ],
    );
  }

  Widget _buildHairColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 23.v),
        Text(
          "lbl_naturalHairColor".tr,
          style: CustomTextStyles.titleSmallGray60004,
        ),
        SizedBox(height: 16.v),
        ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 12.v,
            );
          },
          itemCount: controller.hairColor.length,
          itemBuilder: (context, index) {
            return _buildSelectionWidget(
                controller.hairColor[index], controller.selectedHairColor);
          },
        ),
      ],
    );
  }

  Widget _buildMusicPreference() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 23.v),
        Text(
          "lbl_musicpreference".tr,
          style: CustomTextStyles.titleSmallGray60004,
        ),
        SizedBox(height: 16.v),
        ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 12.v,
            );
          },
          itemCount: controller.musicPreference.length,
          itemBuilder: (context, index) {
            return _buildSelectionWidget(controller.musicPreference[index],
                controller.selectedMusicPreference);
          },
        ),
        SizedBox(height: 123.v),
      ],
    );
  }

  Widget _buildMartialStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 23.v),
        Text(
          "lbl_maritalStatus".tr,
          style: CustomTextStyles.titleSmallGray60004,
        ),
        SizedBox(height: 16.v),
        ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 12.v,
            );
          },
          itemCount: controller.martialStatus.length,
          itemBuilder: (context, index) {
            return _buildSelectionWidget(controller.martialStatus[index],
                controller.selectedMartialStatus);
          },
        ),
      ],
    );
  }

  Widget getWidget(String mapKey) {
    switch (mapKey) {
      case 'height':
        return _buildHeight();
      case 'horoscope':
        return _buildHonoscope();
      case 'smokingStatus':
        return _buildSmokingWidget();
      case 'drinkingStatus':
        return _buildDrinkStatusWidget();
      case 'religion':
        return _buildReligionWidget();
      case 'children':
        return _buildChildrenStatusWidget();
      case 'naturalHairColor':
        return _buildHairColor();
      case 'musicPreference':
        return _buildMusicPreference();
      case 'maritalStatus':
        return _buildMartialStatus();
      default:
        return Text('no Widget Found');
    }
  }

  getOnSave(String mapKey) {
    switch (mapKey) {
      case 'height':
        return save(controller.heightController.text);
      case 'horoscope':
        return save(controller.selectedHonoscope.value);
      case 'smokingStatus':
        return save(controller.selectedSmokingStatus.value);
      case 'drinkingStatus':
        return save(controller.selectedDrinkingStatus.value);
      case 'religion':
        return save(controller.religionController.text);
      case 'children':
        return save(controller.selectedChildrenStatus.value);
      case 'naturalHairColor':
        return save(controller.selectedHairColor.value);
      case 'musicPreference':
        return save(controller.selectedMusicPreference.value);
      case 'maritalStatus':
        return save(controller.selectedMartialStatus.value);
      default:
        return Text('no Widget Found');
    }
  }

  setValue(String mapKey) {
    print('setValue');
    switch (mapKey) {
      case 'height':
        return controller.heightController.text =
            value.replaceAll('cm', '').trim();

      case 'horoscope':
        return controller.selectedHonoscope.value = value;

      case 'smokingStatus':
        return controller.selectedSmokingStatus.value = value;

      case 'drinkingStatus':
        return controller.selectedDrinkingStatus.value = value;

      case 'religion':
        return controller.religionController.text = value;

      case 'children':
        return controller.selectedChildrenStatus.value = value;

      case 'naturalHairColor':
        return controller.selectedHairColor.value = value;

      case 'musicPreference':
        return controller.selectedMusicPreference.value = value;

      case 'maritalStatus':
        return controller.selectedMartialStatus.value = value;

      default:
        return print('no method Found');
    }
  }

  void convertCmToFeetAndInches(double cm) {
    double inches = cm / 2.54;
    double feet = inches / 12;
    inches %= 12;
    controller.heightInFeetController.text = feet.floor().toString();
    controller.heightInInchController.text = inches.round().toString();

    print('${cm}cm is ${feet.floor()} feet and ${inches.round()} inches.');
  }

  double convertFeetAndInchesToCm(int feet, int inches) {
    int totalInches = (feet * 12) + inches;
    double cm = totalInches * 2.54;
    print('CM==>$cm');
    controller.heightController.text = cm.ceil().toString();
    return cm;
  }

  void save(String value) async {
    ProgressDialogUtils.showProgressDialog();
    var newMap = additionalPersonalInfo.toJson();
    newMap[mapKey] = value;
    UserModel userModel = UserModel(
        additionalPersonalInfo: AdditionalPersonalInfo.fromJson(newMap));
    await FirebaseServices.updateUser(userModel);
    ProgressDialogUtils.hideProgressDialog();
    Fluttertoast.showToast(msg: 'Success');
    Get.back();
  }
}
