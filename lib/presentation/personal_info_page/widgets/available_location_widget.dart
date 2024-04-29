import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

// ignore: must_be_immutable
class AvailableLocationWidget extends StatelessWidget {
  AvailableLocationWidget(this.text, {Key? key}) : super(key: key);

  String text;
  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 8.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        text,
        //availableLocationModel.madridEupore!.value,
        style: TextStyle(
          color: appTheme.gray900,
          fontSize: 14.fSize,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
        ),
      ),
      //selected: (availableLocationModel.isSelected?.value ?? false),
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
      // : RoundedRectangleBorder(
      //     side: BorderSide.none,
      //     borderRadius: BorderRadius.circular(
      //       18.h,
      //     ),
      //   ),
      onSelected: (value) {
        // availableLocationModel.isSelected!.value = value;
      },
    );
  }
}
