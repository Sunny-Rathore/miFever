import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/timer_utils.dart';
import 'package:mifever/presentation/question_one_screen/controller/question_one_controller.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_outlined_button.dart';

import '../../data/sevices/media_services/audio_services.dart';

class QuestionOneOneDialog extends StatelessWidget {
  QuestionOneOneDialog({Key? key}) : super(key: key);
  final controller = Get.find<QuestionOneController>();
  final timerController = Get.put(TimerUtils());
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadiusStyle.roundedBorder12,
      child: Container(
        width: 320.h,
        padding: EdgeInsets.all(24.h),
        decoration: AppDecoration.fillPrimary.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImageView(
              onTap: () {
                Get.back();
                controller.recordedFilePath.value = '';
                VoiceRecorderController.isRecording.value = false;
                VoiceRecorderController.stopRecording();
                timerController.stopTimer();
              },
              imagePath: ImageConstant.imgArrowRightGray60004,
              height: 24.adaptSize,
              width: 24.adaptSize,
              alignment: Alignment.centerRight,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 86.h),
              padding: EdgeInsets.all(10.h),
              decoration: AppDecoration.fillRed.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder50,
              ),
              child: Container(
                height: 80.adaptSize,
                width: 80.adaptSize,
                padding: EdgeInsets.symmetric(
                  horizontal: 22.h,
                  vertical: 17.v,
                ),
                decoration: AppDecoration.fillRedA.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder40,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.imgMenu,
                  height: 44.v,
                  width: 36.h,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(height: 23.v),
            Obx(
              () => Text(
                timerController.timerValue.value,
                //"lbl_00_03".tr,
                style: theme.textTheme.headlineSmall,
              ),
            ),
            SizedBox(height: 15.v),
            Obx(
              () => Visibility(
                visible: !VoiceRecorderController.isRecording.value,
                child: CustomElevatedButton(
                  text: "lbl_start_recording".tr,
                  onPressed: () {
                    timerController.startTimer();
                    VoiceRecorderController.startRecording();
                  },
                ),
              ),
            ),
            SizedBox(height: 15.v),
            Visibility(
              child: Column(
                children: [
                  Obx(
                    () => Visibility(
                      visible: timerController.timerValue.value == '00:00',
                      child: CustomElevatedButton(
                        text: "lbl_continue".tr,
                        onPressed: () async {
                          controller.timingSeconds.value = timerController
                                      .timerValue.value ==
                                  '00:03'
                              ? 0
                              : (timerController.timerValue.value == '00:02'
                                  ? 1
                                  : timerController.timerValue.value == '00:01'
                                      ? 2
                                      : 3);
                          timerController.stopTimer();
                          controller.recordedFilePath.value =
                              await VoiceRecorderController.stopRecording();

                          Get.back();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.v),
                  Obx(
                    () => Visibility(
                      visible: VoiceRecorderController.isRecording.value,
                      child: CustomOutlinedButton(
                        onPressed: () {
                          controller.recordedFilePath.value = '';
                          VoiceRecorderController.isRecording.value = false;
                          VoiceRecorderController.stopRecording();
                          timerController.stopTimer();
                        },
                        height: 42.v,
                        text: "lbl_restart".tr,
                        buttonStyle: CustomButtonStyles.outlineRedATL21,
                        buttonTextStyle: CustomTextStyles.titleMediumRedA200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.v),
          ],
        ),
      ),
    );
  }
}
