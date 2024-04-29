import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import '../controller/my_likes_controller.dart';
import '../models/today2_item_model.dart';

// ignore: must_be_immutable
class Today2ItemWidget extends StatelessWidget {
  Today2ItemWidget(
    this.today2ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Today2ItemModel today2ItemModelObj;

  var controller = Get.find<MyLikesController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgEllipse159140x40,
          height: 40.adaptSize,
          width: 40.adaptSize,
          radius: BorderRadius.circular(
            20.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "msg_you_liked_kane_williamson".tr,
                style: theme.textTheme.titleSmall,
              ),
              SizedBox(height: 4.v),
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
            left: 25.h,
            top: 3.v,
            bottom: 5.v,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 4.h,
            top: 6.v,
            bottom: 17.v,
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
