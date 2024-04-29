import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/question_four_screen/controller/question_four_controller.dart';

import '../models/chipview_item_model.dart';

// ignore: must_be_immutable
class ChipviewItemWidget extends StatelessWidget {
  ChipviewItemWidget(this.chipviewItemModelObj, {Key? key}) : super(key: key);

  ChipviewItemModel chipviewItemModelObj;
  final controller = Get.find<QuestionFourController>();
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
            chipviewItemModelObj.playlist!.value,
            style: TextStyle(
              color: (chipviewItemModelObj.isSelected?.value ?? false)
                  ? Colors.white
                  : appTheme.gray60002,
              fontSize: 14.fSize,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
            ),
          ),
          avatar: CustomImageView(
            imagePath: chipviewItemModelObj.playlistImg!.value,
            //ImageConstant.imgPlaylist,
            height: 16.adaptSize,
            width: 16.adaptSize,
            color: (chipviewItemModelObj.isSelected?.value ?? false)
                ? Colors.white
                : appTheme.gray60002,
            margin: EdgeInsets.only(right: 6.h),
          ),
          selected: (chipviewItemModelObj.isSelected?.value ?? false),
          backgroundColor: Colors.transparent,
          selectedColor: appTheme.redA200,
          shape: (chipviewItemModelObj.isSelected?.value ?? false)
              ? RoundedRectangleBorder(
                  side: BorderSide(
                    color: appTheme.gray200,
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
            chipviewItemModelObj.isSelected!.value = value;
            controller.selectedInterest.value =
                chipviewItemModelObj.playlist!.value;
            if (controller.selectedInterestList
                .contains(chipviewItemModelObj.playlist!.value)) {
              controller.selectedInterestList
                  .remove(chipviewItemModelObj.playlist!.value);
            } else {
              controller.selectedInterestList
                  .add(chipviewItemModelObj.playlist!.value);
            }
            //controller.selectedInterestList.add(element)
          },
        ),
      ),
    );
  }
}
