// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import 'controller/sucess_msg_controller.dart';

class SucessMsgDialog extends StatelessWidget {
  SucessMsgDialog(this.controller, this.message, {Key? key}) : super(key: key);

  SucessMsgController controller;
  String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadiusStyle.roundedBorder12,
      child: Container(
        width: 320.h,
        padding: EdgeInsets.symmetric(
          horizontal: 24.h,
          vertical: 36.v,
        ),
        decoration: AppDecoration.fillPrimary.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100.adaptSize,
              width: 100.adaptSize,
              padding: EdgeInsets.all(10.h),
              decoration: AppDecoration.fillRed.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder50,
              ),
              child: CustomImageView(
                imagePath: ImageConstant.imgCheckmark,
                height: 80.adaptSize,
                width: 80.adaptSize,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(height: 26.v),
            Container(
              width: 243.h,
              margin: EdgeInsets.only(
                left: 13.h,
                right: 15.h,
              ),
              child: Text(
                message,
                // "msg_your_account_has".tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.titleMediumGray900ExtraBold.copyWith(
                  height: 1.50,
                ),
              ),
            ),
            SizedBox(height: 13.v),
            CustomElevatedButton(
              text: "msg_continue_to_login".tr,
              onPressed: _onTapContinueLogin,
            ),
          ],
        ),
      ),
    );
  }

  _onTapContinueLogin() {
    Get.offAllNamed(AppRoutes.signInScreen);
  }
}
