// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_bottom_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import 'controller/empty_state_one_controller.dart';
import 'models/empty_state_one_model.dart';

class EmptyStateOnePage extends StatelessWidget {
  EmptyStateOnePage({Key? key}) : super(key: key);

  EmptyStateOneController controller =
      Get.put(EmptyStateOneController(EmptyStateOneModel().obs));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: AppDecoration.fillPrimary,
      child: Column(
        children: [
          SizedBox(height: 160.v),
          _buildKeepScrolling(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildKeepScrolling() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.h),
      child: Column(
        children: [
          Container(
            height: 120.h,
            width: 120.v,
            decoration: AppDecoration.fillRed.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder60,
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgUserOnprimary,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(height: 19.v),
          Text(
            "msg_you_haven_t_liked".tr,
            style: CustomTextStyles.titleMediumGray900,
          ),
          SizedBox(height: 9.v),
          Text(
            "msg_please_keep_scrolling".tr,
            style: theme.textTheme.bodySmall,
          ),
          SizedBox(height: 14.v),
          CustomElevatedButton(
            onPressed: () {
              final controller = Get.find<CustomBottomBarController>();
              controller.selectedIndex.value = 0;
            },
            text: "lbl_keep_scrolling2".tr,
          ),
        ],
      ),
    );
  }
}
