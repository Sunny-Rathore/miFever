// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import 'controller/empty_state_controller.dart';
import 'models/empty_state_model.dart';

class EmptyStatePage extends StatelessWidget {
  EmptyStatePage({Key? key}) : super(key: key);

  EmptyStateController controller =
      Get.put(EmptyStateController(EmptyStateModel().obs));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: AppDecoration.fillPrimary,
      child: Column(
        children: [
          SizedBox(height: 151.v),
          _buildUpgradeYourPlan(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUpgradeYourPlan() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.h),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 120.h,
            width: 120.v,
            decoration: AppDecoration.fillRed.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder60,
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgUserOnprimary,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 19.v),
          Text(
            "msg_no_one_liked_your".tr,
            style: CustomTextStyles.titleMediumGray900,
          ),
          SizedBox(height: 8.v),
          Container(
            width: 317.h,
            margin: EdgeInsets.only(
              left: 2.h,
              right: 3.h,
            ),
            child: Text(
              "msg_if_you_want_to_enhance".tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall!.copyWith(
                height: 1.50,
              ),
            ),
          ),
          SizedBox(height: 14.v),
          CustomElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.subscriptionPlansScreen);
            },
            text: "msg_upgrade_your_plan3".tr,
          ),
        ],
      ),
    );
  }
}
