// ignore_for_file: deprecated_member_use

import 'dart:developer' as consol;

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_icon_button.dart';
import 'package:mifever/widgets/custom_text_form_field.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/sevices/media_services/audio_services.dart';
import '../question_one_one_dialog/question_one_one_dialog.dart';
import 'controller/question_one_controller.dart';

// ignore_for_file: must_be_immutable
class QuestionOneScreen extends GetWidget<QuestionOneController> {
  QuestionOneScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          PrefUtils.clearPreferencesData();
          Get.offAllNamed(AppRoutes.onboardingScreen);
          return true;
        },
        child: Scaffold(
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
                    vertical: 11.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 8.v,
                        width: 335.h,
                        decoration: BoxDecoration(
                          color: appTheme.red50,
                          borderRadius: BorderRadius.circular(
                            4.h,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            4.h,
                          ),
                          child: LinearProgressIndicator(
                            value: 0.14,
                            color: appTheme.redA200,
                            backgroundColor: appTheme.red50,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.v),
                      Text(
                        "lbl_say_your_name".tr,
                        style: theme.textTheme.headlineSmall,
                      ),
                      SizedBox(height: 22.v),
                      CustomTextFormField(
                        controller: controller.nameController,
                        hintText: "lbl_enter_your_name".tr,
                        hintStyle: CustomTextStyles.bodySmall12,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null) {
                            return "err_msg_please_enter_valid_name".tr;
                          }
                          return null;
                        },
                        onChanged: (val) {
                          controller.isButtonDisable.value = val.isEmpty;
                        },
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.h,
                          vertical: 13.v,
                        ),
                      ),
                      SizedBox(height: 37.v),
                      Obx(
                        () => Visibility(
                            visible: controller.recordedFilePath.value.isEmpty,
                            child: _buildQuestionOneTwoFrameTwentyFive()),
                      ),
                      SizedBox(height: 5.v),
                      Obx(
                        () => Visibility(
                          visible: controller.recordedFilePath.value.isNotEmpty,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "msg_your_voice_recording".tr,
                                style: CustomTextStyles
                                    .titleMediumGray900ExtraBold,
                              ),
                              SizedBox(height: 10.v),
                              _buildFrameRecordedIndicator()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomSheet: _buildContinue(),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingImage(
        onTap: () {
          PrefUtils.clearPreferencesData();
          Get.offAllNamed(AppRoutes.onboardingScreen);
          //Get.back();
        },
        imagePath: ImageConstant.imgElementsGray900,
        margin: EdgeInsets.fromLTRB(25.h, 21.v, 330.h, 22.v),
      ),
    );
  }

  /// Section Widget
  Widget _buildQuestionOneTwoFrameTwentyFive() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Visibility(
            visible: controller.isRecording.value,
            child: Expanded(child: _buildVoiceRecord()),
            replacement: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "msg_record_your_name".tr,
                  style: CustomTextStyles.titleMediumGray900ExtraBold,
                ),
                SizedBox(height: 3.v),
                Text(
                  "msg_you_can_record_your".tr,
                  style: CustomTextStyles.bodySmall12,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 11.h),
        Padding(
          padding: EdgeInsets.only(bottom: 2.v),
          child: Tooltip(
            message: 'Hold to record, release to send',
            triggerMode: TooltipTriggerMode.tap,
            child: GestureDetector(
              onLongPressMoveUpdate: (details) async {
                Offset myOffset = details.localOffsetFromOrigin;
                double firstValue = myOffset.dx;
                if (firstValue < -30.0) {
                  consol.log('isVoiceCancel');
                  controller.isVoiceCancel.value = true;
                  await VoiceRecorderController.stopRecording();
                }
              },
              onLongPressEnd: (val) async {
                PermissionStatus status = await Permission.microphone.request();
                if (status.isGranted) {
                  int timerValue = controller.timerCount.value;
                  print("timerValue::$timerValue");
                  controller.isRecordingOn(false);
                  controller.isRecording(false);
                  controller.stopRecodeTimer();
                  if (!controller.isVoiceCancel.value) {
                    await VoiceRecorderController.stopRecording();
                    consol.log(VoiceRecorderController.recordingPath.value);
                    if (timerValue > 0) {
                      controller.recordedFilePath.value =
                          VoiceRecorderController.recordingPath.value;
                    }
                  }
                } else if (status.isPermanentlyDenied) {
                  openAppSettings();
                }
                controller.isVoiceCancel.value = false;
              },
              onLongPress: () async {
                PermissionStatus status = await Permission.microphone.request();
                if (status.isGranted) {
                  controller.isRecording(true);
                  await VoiceRecorderController.startRecording();
                  controller.isRecordingOn(true);
                  controller.startRecordTimer();
                }
              },
              child: CustomIconButton(
                decoration: IconButtonStyleHelper.fillRedA,
                height: 40.adaptSize,
                width: 40.adaptSize,
                padding: EdgeInsets.all(8.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgMic01,
                ),
                // onTap: _onTapMicButton,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildVoiceRecord() {
    return Container(
      decoration: BoxDecoration(
          color: appTheme.red100, borderRadius: BorderRadius.circular(120)),
      padding: EdgeInsets.symmetric(vertical: 12.v, horizontal: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: 12.h),
          CustomImageView(
            imagePath: ImageConstant.imgMic01,
            color: Color(0xff92163A),
          ),
          SizedBox(width: 12.h),
          Obx(
            () => Text(
              //'0:0',
              controller.formatTime(),
              style: CustomTextStyles.titleMediumBlack900,
            ),
          ),
          const Text(
            ' < Left swipe to cancel',
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameRecordedIndicator() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(12.h),
            decoration: AppDecoration.fillRed.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder4,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 11.v),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 8.v,
                          width: 233.h,
                          decoration: BoxDecoration(
                            color: appTheme.red100,
                            borderRadius: BorderRadius.circular(
                              4.h,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              4.h,
                            ),
                          ),
                        ),
                        Obx(
                          () => LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(10.h),
                            minHeight: 8.v,
                            value: controller.progress.value,
                            color: appTheme.redA200,
                            backgroundColor: appTheme.red100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.h),
                  child: CustomIconButton(
                    onTap: () async {
                      controller.isPlaying.value = !controller.isPlaying.value;
                      if (controller.isPlaying.value) {
                        controller.startTimer();
                        await VoiceRecorderController.playAudio(
                            controller.recordedFilePath.value);
                      } else {
                        VoiceRecorderController.stopAudio();
                        controller.timer.cancel();
                      }
                    },
                    height: 30.adaptSize,
                    width: 30.adaptSize,
                    padding: EdgeInsets.all(6.h),
                    decoration: IconButtonStyleHelper.fillRedATL15,
                    child: Obx(
                      () => controller.isPlaying.value
                          ? Icon(
                              Icons.pause,
                              color: Colors.white,
                              size: 15.h,
                            )
                          : CustomImageView(
                              imagePath: ImageConstant.imgFavorite,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRightGray60004,
          height: 24.adaptSize,
          width: 24.adaptSize,
          margin: EdgeInsets.only(
            left: 12.h,
            top: 15.v,
            bottom: 15.v,
          ),
          onTap: () {
            VoiceRecorderController.stopAudio();
            controller.recordedFilePath.value = '';
            VoiceRecorderController.isRecording.value = false;
            VoiceRecorderController.stopRecording();
          },
        ),
      ],
    );
  }

  _onTapMicButton() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status.isGranted) {
      Get.dialog(Center(child: QuestionOneOneDialog()),
          barrierDismissible: false);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  /// Section Widget
  Widget _buildContinue() {
    return Obx(
      () => CustomElevatedButton(
        text: "lbl_continue".tr,
        margin: EdgeInsets.only(
          left: 20.h,
          right: 20.h,
          bottom: 36.v,
        ),
        rightIcon: Container(
          margin: EdgeInsets.only(left: 4.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgArrowleft02sharp,
            height: 24.adaptSize,
            width: 24.adaptSize,
          ),
        ),
        buttonStyle: controller.isButtonDisable.value ||
                controller.recordedFilePath.value.isEmpty
            ? CustomButtonStyles.fillGray
            : null,
        onPressed: controller.isButtonDisable.value ||
                controller.recordedFilePath.value.isEmpty
            ? null
            : _onTapContinue,
      ),
    );
  }

  _onTapContinue() {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      Get.toNamed(AppRoutes.questionTwoScreen);
    }
  }
}
