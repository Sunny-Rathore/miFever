import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../controller/liked_me_controller.dart';
import '../models/frame13_item_model.dart';

// ignore: must_be_immutable
class Frame13ItemWidget extends StatelessWidget {
  Frame13ItemWidget(
    this.frame13ItemModelObj, {
    Key? key,
  }) : super(key: key);

  Frame13ItemModel frame13ItemModelObj;

  var controller = Get.find<LikedMeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.h,
        vertical: 11.v,
      ),
      decoration: AppDecoration.gradientRedAToOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      width: 101.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Text(
              frame13ItemModelObj.dynamicText!.value,
              style: CustomTextStyles.titleMediumExtraBold,
            ),
          ),
          SizedBox(height: 2.v),
          Obx(
            () => Text(frame13ItemModelObj.dynamicText1!.value,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: theme.colorScheme.primary,
                  fontSize: 12,
                )),
          ),
        ],
      ),
    );
  }
}
