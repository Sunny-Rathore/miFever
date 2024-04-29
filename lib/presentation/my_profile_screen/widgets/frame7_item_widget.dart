import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import '../controller/my_profile_controller.dart';
import '../models/frame7_item_model.dart';

// ignore: must_be_immutable
class Frame7ItemWidget extends StatelessWidget {
  Frame7ItemWidget(this.frame7ItemModelObj, {Key? key}) : super(key: key);

  Frame7ItemModel frame7ItemModelObj;

  var controller = Get.find<MyProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.h),
      decoration: frame7ItemModelObj.id!.value == PlanType.Platinum.name
          ? AppDecoration.gradientGrayToGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder9,
            )
          : AppDecoration.gradientLimeToLime.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder9,
            ),
      width: 157.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: frame7ItemModelObj.id!.value == PlanType.Platinum.name
                ? ImageConstant.imgPlatinum
                : ImageConstant.imgGroup25Gray900,
            height: 60.adaptSize,
            width: 60.adaptSize,
          ),
          SizedBox(height: 12.v),
          Obx(
            () => Text(
              frame7ItemModelObj.buyGoldPlanText!.value,
              style: CustomTextStyles.titleSmallPrimaryExtraBold,
            ),
          ),
          SizedBox(height: 3.v),
          SizedBox(
            width: 107.h,
            child: Obx(
              () => Text(
                frame7ItemModelObj.loremIpsumDolorText!.value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.bodySmallPrimary.copyWith(
                  height: 1.45,
                ),
              ),
            ),
          ),
          SizedBox(height: 11.v),
          CustomElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.subscriptionPlansScreen, parameters: {
                'index': frame7ItemModelObj.id!.value == PlanType.Platinum.name
                    ? '1'
                    : '0'
              });
            },
            height: 30.v,
            width: 110.h,
            text: "lbl_view_details".tr,
            buttonStyle: CustomButtonStyles.fillPrimaryTL15,
            buttonTextStyle: CustomTextStyles.labelLargeLime80001,
          ),
        ],
      ),
    );
  }
}
