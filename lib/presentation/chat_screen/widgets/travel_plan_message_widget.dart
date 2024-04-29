import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../models/chat_model.dart';

class TravelPlanMessageWidget extends StatelessWidget {
  const TravelPlanMessageWidget({Key? key, required this.chat})
      : super(key: key);
  final ChatModel chat;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: chat.senderId == PrefUtils.getId()
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        width: SizeUtils.width - 100.h,
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: chat.senderId == PrefUtils.getId()
                ? appTheme.redA200
                : appTheme.red100,
            width: 1.h,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  chat.travelPlan?.planName ?? '',
                  style: CustomTextStyles.titleMediumBlack900,
                ),
              ],
            ),
            Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgCalendar03,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                ),
                SizedBox(width: 8.v),
                Text(
                    '${DateTime.parse(chat.travelPlan?.startDate ?? "").format()} ${DateTime.parse(chat.travelPlan?.endDate ?? "").format()}')
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLocation01RedA200,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                ),
                SizedBox(width: 8.v),
                Expanded(
                  child: Text(chat.travelPlan?.location ?? ""),
                )
              ],
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
