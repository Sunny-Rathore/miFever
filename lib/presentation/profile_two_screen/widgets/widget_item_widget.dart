import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import '../controller/profile_two_controller.dart';
import '../models/widget_item_model.dart';

// ignore: must_be_immutable
class WidgetItemWidget extends StatelessWidget {
  WidgetItemWidget(
    this.widgetItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  WidgetItemModel widgetItemModelObj;

  var controller = Get.find<ProfileTwoController>();

  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      imagePath: ImageConstant.imgRectangle17848,
      height: 295.v,
      width: 375.h,
    );
  }
}
