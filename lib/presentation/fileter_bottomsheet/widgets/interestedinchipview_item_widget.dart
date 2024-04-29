import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import '../models/interestedinchipview_item_model.dart';

// ignore: must_be_immutable
class InterestedinchipviewItemWidget extends StatelessWidget {
  InterestedinchipviewItemWidget(
    this.interestedinchipviewItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  InterestedinchipviewItemModel interestedinchipviewItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Theme(
        data: ThemeData(
          canvasColor: Colors.transparent,
        ),
        child: RawChip(
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 8.v,
          ),
          showCheckmark: false,
          labelPadding: EdgeInsets.zero,
          label: Text(
            interestedinchipviewItemModelObj.man!.value,
            style: TextStyle(
              color:
                  (interestedinchipviewItemModelObj.isSelected?.value ?? false)
                      ? theme.colorScheme.primary
                      : appTheme.gray60004,
              fontSize: 14.fSize,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
            ),
          ),
          selected:
              (interestedinchipviewItemModelObj.isSelected?.value ?? false),
          backgroundColor: Colors.transparent,
          selectedColor: appTheme.redA200,
          shape: (interestedinchipviewItemModelObj.isSelected?.value ?? false)
              ? RoundedRectangleBorder(
                  side: BorderSide.none,
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
            interestedinchipviewItemModelObj.isSelected!.value = value;
          },
        ),
      ),
    );
  }
}
