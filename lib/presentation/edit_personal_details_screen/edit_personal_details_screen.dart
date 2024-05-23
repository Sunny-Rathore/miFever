import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/validation_functions.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_text_form_field.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/sevices/google_places_services.dart';
import '../../data/sevices/media_services/audio_services.dart';
import '../../widgets/custom_icon_button.dart';
import '../question_one_one_dialog/question_one_one_dialog.dart';
import 'controller/edit_personal_details_controller.dart';
import 'models/profliedetailseditpersonaldeta_item_model.dart';
import 'widgets/profliedetailseditpersonaldeta_item_widget.dart';

// ignore_for_file: must_be_immutable
class EditPersonalDetailsScreen
    extends GetWidget<EditPersonalDetailsController> {
  EditPersonalDetailsScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          VoiceRecorderController.stopAudio();
          controller.timer.cancel();
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
                    vertical: 24.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "lbl_name".tr,
                        style: CustomTextStyles.titleSmallGray60004,
                      ),
                      SizedBox(height: 7.v),
                      _buildName(),
                      SizedBox(height: 23.v),
                      Text(
                        "lbl_email".tr,
                        style: CustomTextStyles.titleSmallGray60004,
                      ),
                      SizedBox(height: 8.v),
                      _buildEmail(),
                      SizedBox(height: 24.v),
                      Text(
                        "lbl_birth_date".tr,
                        style: CustomTextStyles.titleSmallGray60004,
                      ),
                      SizedBox(height: 8.v),
                      _buildBirthDate(),
                      SizedBox(height: 23.v),
                      Text(
                        "lbl_gender".tr,
                        style: CustomTextStyles.titleSmallGray60004,
                      ),
                      SizedBox(height: 6.v),
                      _buildGender(),
                      SizedBox(height: 25.v),
                      Text(
                        "lbl_location".tr,
                        style: CustomTextStyles.titleSmallGray60004,
                      ),
                      SizedBox(height: 6.v),
                      _buildLocationField(controller.locationController),
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                side: BorderSide(color: Colors.grey),
                                checkColor: Colors.white,
                                activeColor: Colors.red,
                                value: controller.isCurrentLocation.value,
                                onChanged: (val) async {
                                  PrefUtils.setIsCurrentLocation(val!);
                                  controller.isCurrentLocation.value = val;
                                }),
                          ),
                          Text('Is  this your current location')
                        ],
                      ),
                      SizedBox(height: 25.v),
                      Container(
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Visibility(
                                  visible:
                                      controller.recordedFilePath.value.isEmpty,
                                  child: _buildQuestionOneTwoFrameTwentyFive()),
                            ),
                            SizedBox(height: 5.v),
                            Obx(
                              () => Visibility(
                                visible: controller
                                    .recordedFilePath.value.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "msg_your_voice_recording".tr,
                                      style:
                                          CustomTextStyles.titleSmallGray60004,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomSheet: _buildFrame(),
        ),
      ),
    );
  }

  // /// Section Widget
  // Widget _buildQuestionOneTwoFrameTwentyFive() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             "msg_record_your_name".tr,
  //             style: CustomTextStyles.titleMediumGray900ExtraBold,
  //           ),
  //           SizedBox(height: 3.v),
  //           Text(
  //             "msg_you_can_record_your".tr,
  //             style: CustomTextStyles.bodySmall12,
  //           ),
  //         ],
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(bottom: 2.v),
  //         child: CustomIconButton(
  //           decoration: IconButtonStyleHelper.fillRedA,
  //           height: 40.adaptSize,
  //           width: 40.adaptSize,
  //           padding: EdgeInsets.all(8.h),
  //           child: CustomImageView(
  //             imagePath: ImageConstant.imgMic01,
  //           ),
  //           onTap: _onTapMicButton,
  //         ),
  //       ),
  //     ],
  //   );
  // }
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
                  //consol.log('isVoiceCancel');
                  controller.isVoiceCancel.value = true;
                  await VoiceRecorderController.stopRecording();
                }
              },
              onLongPressEnd: (val) async {
                // PermissionStatus status = await Permission.microphone.request();
                // if (status.isGranted) {
                int timerValue = controller.timerCount.value;
                print("timerValue::$timerValue");
                controller.isRecordingOn(false);
                controller.isRecording(false);
                controller.stopRecodeTimer();

                if (!controller.isVoiceCancel.value) {
                  await VoiceRecorderController.stopRecording();
                  if (timerValue > 0) {
                    controller.recordedFilePath.value =
                        VoiceRecorderController.recordingPath.value;
                  }
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
                } else if (status.isPermanentlyDenied) {
                  openAppSettings();
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

  // /// Section Widget
  // Widget _buildFrameRecordedIndicator() {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: Container(
  //           padding: EdgeInsets.all(12.h),
  //           decoration: AppDecoration.fillRed.copyWith(
  //             borderRadius: BorderRadiusStyle.roundedBorder4,
  //           ),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: Padding(
  //                   padding: EdgeInsets.symmetric(vertical: 11.v),
  //                   child: Stack(
  //                     alignment: Alignment.center,
  //                     children: [
  //                       Container(
  //                         height: 8.v,
  //                         width: 233.h,
  //                         decoration: BoxDecoration(
  //                           color: appTheme.red100,
  //                           borderRadius: BorderRadius.circular(
  //                             4.h,
  //                           ),
  //                         ),
  //                         child: ClipRRect(
  //                           borderRadius: BorderRadius.circular(
  //                             4.h,
  //                           ),
  //                         ),
  //                       ),
  //                       Obx(
  //                         () => LinearProgressIndicator(
  //                           borderRadius: BorderRadius.circular(10.h),
  //                           minHeight: 8.v,
  //                           value: questionOneController.progress.value,
  //                           color: appTheme.redA200,
  //                           backgroundColor: appTheme.red100,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.only(left: 12.h),
  //                 child: CustomIconButton(
  //                   onTap: () async {
  //                     questionOneController.isPlaying.value =
  //                         !questionOneController.isPlaying.value;
  //                     if (questionOneController.isPlaying.value) {
  //                       questionOneController.startTimer();
  //                       questionOneController.progress.value = 0.0;
  //                       questionOneController.timingSeconds.value = 3.0;
  //                       await VoiceRecorderController.playAudio(
  //                           questionOneController.recordedFilePath.value);
  //                     } else {
  //                       VoiceRecorderController.stopAudio();
  //                       questionOneController.timer.cancel();
  //                     }
  //                   },
  //                   height: 30.adaptSize,
  //                   width: 30.adaptSize,
  //                   padding: EdgeInsets.all(6.h),
  //                   decoration: IconButtonStyleHelper.fillRedATL15,
  //                   child: Obx(
  //                     () => questionOneController.isPlaying.value
  //                         ? Icon(
  //                             Icons.pause,
  //                             color: Colors.white,
  //                             size: 15.h,
  //                           )
  //                         : CustomImageView(
  //                             imagePath: ImageConstant.imgFavorite,
  //                           ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       CustomImageView(
  //         imagePath: ImageConstant.imgArrowRightGray60004,
  //         height: 24.adaptSize,
  //         width: 24.adaptSize,
  //         margin: EdgeInsets.only(
  //           left: 12.h,
  //           top: 15.v,
  //           bottom: 15.v,
  //         ),
  //         onTap: () {
  //           VoiceRecorderController.stopAudio();
  //           questionOneController.recordedFilePath.value = '';
  //           VoiceRecorderController.isRecording.value = false;
  //           VoiceRecorderController.stopRecording();
  //         },
  //       ),
  //     ],
  //   );
  // }

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
        text: "msg_edit_personal_details".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildName() {
    return CustomTextFormField(
      controller: controller.nameController,
      hintText: "lbl_name".tr,
      hintStyle: CustomTextStyles.bodySmall12,
      contentPadding: EdgeInsets.all(12.h),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "err_msg_please_enter_valid_name".tr;
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildEmail() {
    return CustomTextFormField(
      controller: controller.emailController,
      hintText: "msg_enter_email_address".tr,
      hintStyle: CustomTextStyles.bodySmall12,
      textInputType: TextInputType.emailAddress,
      contentPadding: EdgeInsets.all(12.h),
      prefixConstraints: BoxConstraints(
        maxHeight: 44.v,
      ),
      validator: (value) {
        if (value == null || (!isValidEmail(value, isRequired: true))) {
          return "err_msg_please_enter_valid_email".tr;
        }
        return null;
      },
      onChanged: (val) {},
    );
  }

  /// Section Widget
  Widget _buildGender() {
    return SizedBox(
      height: 20.h,
      child: Padding(
        padding: EdgeInsets.only(right: 75.h),
        child: Obx(
          () => ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                width: 12.v,
              );
            },
            itemCount: controller.proflieDetailsEditPersonalDetailsModelObj
                .value.profliedetailseditpersonaldetaItemList.value.length,
            itemBuilder: (context, index) {
              ProfliedetailseditpersonaldetaItemModel model = controller
                  .proflieDetailsEditPersonalDetailsModelObj
                  .value
                  .profliedetailseditpersonaldetaItemList
                  .value[index];
              return ProfliedetailseditpersonaldetaItemWidget(
                model,
              );
            },
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildLocationField(TextEditingController textEditingController) {
    return CustomTextFormField(
      readOnly: true,
      controller: textEditingController,
      hintText: "lbl_enter_location".tr,
      hintStyle: CustomTextStyles.bodySmall12,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgLocation01,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 44.v,
      ),
      textInputType: TextInputType.name,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "lbl_enter_location".tr;
        }
        return null;
      },
      onTap: () async {
        await GooglePlacesApiServices.placeSelectAPI(
                Get.context!, textEditingController.text)
            .then((value) {
          textEditingController.text =
              value!.result.formattedAddress.toString();
          // controller.isMakeButtonDisable();
          // controller.locationLatLong.value = GeoPoint(
          //   value.result.geometry!.location.lat,
          //   value.result.geometry!.location.lng,
          // );
        });
      },
    );
  }

  /// Section Widget
  Widget _buildBirthDate() {
    return GestureDetector(
      onTap: () {
        _showDatePicker(Get.context!);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 11.h,
          vertical: 9.v,
        ),
        decoration: AppDecoration.outlineGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 1.v,
                bottom: 1.v,
              ),
              child: Obx(
                () => Text(
                  controller.selectedDate.value,
                  // "msg_select_your_birth".tr,
                  style: theme.textTheme.bodySmall!.copyWith(
                      color: appTheme.gray900, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgCalendar03,
              height: 24.adaptSize,
              width: 24.adaptSize,
            ),
          ],
        ),
      ),
    );
  }

  /// Show calendar in pop up dialog for selecting date range for calendar event.
  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: SizeUtils.width,
            height: SizeUtils.height * 0.45,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Theme(
                  data: ThemeData(indicatorColor: appTheme.redA200),
                  child: CalendarDatePicker(
                    initialDate:
                        DateTime.now().subtract(Duration(days: 18 * 366)),
                    firstDate:
                        DateTime.now().subtract(Duration(days: 60 * 366)),
                    lastDate: DateTime.now().subtract(Duration(days: 18 * 366)),
                    onDateChanged: (DateTime date) {
                      if (date != controller.initialDateTime.value) {
                        controller.initialDateTime.value = date;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.only(right: 20.v),
                  shape: RoundedRectangleBorder()),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: appTheme.redA200, fontSize: 15.fSize),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  minimumSize: Size(140.v, 50.v),
                  backgroundColor: appTheme.redA200),
              onPressed: () {
                controller.selectedDate.value =
                    controller.initialDateTime.value.format();
                Navigator.of(context).pop();
                // Get.dialog(Center(
                //   child: QuestionThreeDialog(
                //       calculateAgeFromString(controller.selectedDate.value)),
                // ));
              },
              child: Text(
                'Add',
              ),
            ),
          ],
        );
      },
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

  void _onTapContinue() {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      controller.onTapContinue();
    }
  }
}
