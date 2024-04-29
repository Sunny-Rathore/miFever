import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/edit_other_details_screen/controller/edit_other_details_controller.dart';
import 'package:mifever/presentation/profile_screen/profile_screen.dart';

import '../models/frame10_item_model.dart';

// ignore: must_be_immutable
class OtherDetailsItemWidget extends StatelessWidget {
  OtherDetailsItemWidget(this.otherDetailsItemWidgetModelObj,
      {Key? key, required this.text})
      : super(key: key);

  OtherDetailsItemWidgetModel otherDetailsItemWidgetModelObj;
  String text;
  final controller = Get.find<EditOtherDetailsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Theme(
        data: ThemeData(
          canvasColor: Colors.transparent,
        ),
        child: RawChip(
          padding: EdgeInsets.only(
            top: 8.v,
            right: 16.h,
            bottom: 8.v,
            left: 16.h,
          ),
          showCheckmark: false,
          labelPadding: EdgeInsets.zero,
          label: Text(
            text,
            style: TextStyle(
              color: controller.selectedInterest.contains(text)
                  ? theme.colorScheme.primary
                  : appTheme.gray60004,
              fontSize: 14.fSize,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
            ),
          ),
          avatar: Obx(
            () => CustomImageView(
              imagePath: matchStringAndGetInterestImage(text),
              // ImageConstant.imgPlaylistGray60004,
              height: 16.adaptSize,
              width: 16.adaptSize,
              color: controller.selectedInterest.contains(text)
                  ? theme.colorScheme.primary
                  : appTheme.gray60004,
              margin: EdgeInsets.only(right: 6.h),
            ),
          ),
          selected: controller.selectedInterest.contains(text),
          backgroundColor: Colors.transparent,
          selectedColor: appTheme.redA200,
          shape: controller.selectedInterest.contains(text)
              ? RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white,
                    width: 1.h,
                  ),
                  borderRadius: BorderRadius.circular(
                    18.h,
                  ),
                )
              : RoundedRectangleBorder(
                  side: BorderSide(
                    color: appTheme.gray200,
                    width: 1.h,
                  ),
                  borderRadius: BorderRadius.circular(
                    18.h,
                  ),
                ),
          onSelected: (value) {
            if (controller.selectedInterest.contains(text)) {
              controller.selectedInterest.remove(text);
            } else {
              controller.selectedInterest.add(text);
            }
            otherDetailsItemWidgetModelObj.isSelected!.value = value;
          },
        ),
      ),
    );
  }
}
