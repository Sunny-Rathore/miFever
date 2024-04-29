import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../../widgets/custom_elevated_button.dart';

class UpgradePlanDialogue extends StatelessWidget {
  const UpgradePlanDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: Get.height,
          padding: EdgeInsets.symmetric(
            horizontal: 27.h,
            // vertical: 225.v,
          ),
          decoration: AppDecoration.fillGray900,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(height: 20.v),
              CustomImageView(
                imagePath: ImageConstant.imgGroup25Primary112x112,
                height: 112.adaptSize,
                width: 112.adaptSize,
              ),
              SizedBox(height: 17.v),
              Container(
                width: 288.h,
                margin: EdgeInsets.only(
                  left: 16.h,
                  right: 15.h,
                ),
                child: Text(
                  "msg_upgrade_your_plan2".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.titleMediumExtraBold.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 13.v),
              CustomElevatedButton(
                text: "msg_upgrade_your_plan3".tr,
                onPressed: () {
                  Get.toNamed(AppRoutes.subscriptionPlansScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
