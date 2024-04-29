import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/profile_screen/profile_screen.dart';

// ignore: must_be_immutable
class YourInterestChipWidget extends StatelessWidget {
  YourInterestChipWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  String text;
  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.all(8.v),
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
      ),
      //selected: (yourInterestModel.isSelected?.value ?? false),
      backgroundColor: appTheme.red50,
      selectedColor: appTheme.red50,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.gray900.withOpacity(0.6),
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(
          18.h,
        ),
      ),

      onSelected: (value) {},
    );
  }
}
