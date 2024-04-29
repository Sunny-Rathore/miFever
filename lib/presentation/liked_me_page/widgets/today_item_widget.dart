import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../controller/liked_me_controller.dart';
import '../models/today_item_model.dart';

// ignore: must_be_immutable
class TodayItemWidget extends StatelessWidget {
  TodayItemWidget(
    this.todayItemModelObj, {
    Key? key,
  }) : super(key: key);

  TodayItemModel todayItemModelObj;

  var controller = Get.find<LikedMeController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgEllipse159140x40,
          height: 40.adaptSize,
          width: 40.adaptSize,
          radius: BorderRadius.circular(
            20.h,
          ),
          margin: EdgeInsets.only(bottom: 17.v),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 8.h,
            bottom: 15.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "msg_kane_williamson".tr,
                style: theme.textTheme.titleSmall!,
              ),
              SizedBox(height: 3.v),
              Text(
                "lbl_12_min_ago".tr,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgGroup63Red50,
          height: 32.v,
          width: 16.h,
          margin: EdgeInsets.only(
            left: 10.h,
            top: 3.v,
            bottom: 21.v,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 4.h,
            top: 6.v,
            bottom: 33.v,
          ),
          child: Text(
            "lbl_10".tr,
            style: theme.textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
