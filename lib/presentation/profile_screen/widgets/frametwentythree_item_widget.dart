import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../profile_screen.dart';

// ignore: must_be_immutable
class InterestChipWidget extends StatelessWidget {
  InterestChipWidget(
    this.text, {
    Key? key,
  }) : super(key: key);

  String text;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.only(
        top: 8.v,
        right: 16.h,
        bottom: 8.v,
        left: 8.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        text,
        style: TextStyle(
          color: appTheme.gray900,
          fontSize: 14.fSize,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
        ),
      ),
      avatar: CustomImageView(
        imagePath: matchStringAndGetInterestImage(text),
        height: 16.v,
        width: 15.h,
        margin: EdgeInsets.only(right: 6.h),
      ),
      // selected: (frametwentythreeItemModelObj.isSelected?.value ?? false),
      backgroundColor: appTheme.red50,
      selectedColor: appTheme.red50,
      shape:
          //  (frametwentythreeItemModelObj.isSelected?.value ?? false)
          //     ?
          RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.gray900.withOpacity(0.6),
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(
          18.h,
        ),
      ),
      // : RoundedRectangleBorder(
      //     side: BorderSide.none,
      //     borderRadius: BorderRadius.circular(
      //       18.h,
      //     ),
      //   ),
      onSelected: (value) {
        // frametwentythreeItemModelObj.isSelected!.value = value;
      },
    );
  }
}
