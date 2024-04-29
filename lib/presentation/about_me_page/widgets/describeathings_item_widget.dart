import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_outlined_button.dart';

import '../controller/about_me_controller.dart.dart';
import '../models/describeathings_item_model.dart';

// ignore: must_be_immutable
class DescribeathingsItemWidget extends StatelessWidget {
  DescribeathingsItemWidget(this.describeathingsItemModelObj, {Key? key})
      : super(key: key);

  DescribeathingsItemModel describeathingsItemModelObj;

  var controller = Get.find<AboutMePageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(11.h),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Text(
              describeathingsItemModelObj.question!.value,
              style: theme.textTheme.titleSmall,
            ),
          ),
          SizedBox(height: 14.v),
          CustomOutlinedButton(
            width: 77.h,
            text: "lbl_add".tr,
            buttonTextStyle: CustomTextStyles.titleSmallRedA200,
            onPressed: () {
              // Get.to(() => AddAboutMeView(
              // text: ,
              // ));
            },
          ),
        ],
      ),
    );
  }
}
