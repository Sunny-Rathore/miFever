import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import '../../../data/sevices/url_lancher.dart';
import '../../chat_three_dialog/chat_three_dialog.dart';
import '../controller/flight_recommendation_controller.dart';
import '../models/flightdetails_item_model.dart';

// ignore: must_be_immutable
class FlightdetailsItemWidget extends StatelessWidget {
  FlightdetailsItemWidget(
    this.flightdetailsItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  FlightdetailsItemModel flightdetailsItemModelObj;

  var controller = Get.find<FlightRecommendationController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('subtitle');
        print(controller.subTitle.value);
        Get.dialog(Center(
            child: ChatThreeDialog(
          onTap: () {
            String date = controller.selectedDate.replaceAll('-', '');
            String newDate = date.substring(2);
            String displayCodeOrigin = flightdetailsItemModelObj
                    .disPlayCodeOrigin?.value
                    .toLowerCase() ??
                '';
            String displayCodeDestination = flightdetailsItemModelObj
                    .disPlayCodeDestination?.value
                    .toLowerCase() ??
                '';
            launchURL(
                'https://www.skyscanner.co.in/transport/flights/$displayCodeOrigin/$displayCodeDestination/$newDate/?adultsv2=1&cabinclass=economy&childrenv2=&inboundaltsenabled=false&outboundaltsenabled=false&preferdirects=false&ref=home&rtn=0&sortby=BEST');
          },
          subTitle: controller.subTitle.value,
        )));
      },
      child: Container(
        padding: EdgeInsets.all(12.h),
        decoration: AppDecoration.outlineGray900.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  height: 26.v,
                  width: 49.h,
                  text:
                      flightdetailsItemModelObj.disPlayCodeOrigin?.value ?? '',
                  //"lbl_cgk".tr,
                  buttonStyle: CustomButtonStyles.fillRedTL14,
                  buttonTextStyle: CustomTextStyles.labelLargeGray60004,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 6.v,
                    bottom: 2.v,
                  ),
                  child: Obx(
                    () => Text(
                      flightdetailsItemModelObj.hrsStop!.value,
                      style: CustomTextStyles.labelLargeOnPrimary,
                    ),
                  ),
                ),
                CustomElevatedButton(
                  height: 26.v,
                  width: 50.h,
                  text:
                      flightdetailsItemModelObj.disPlayCodeDestination?.value ??
                          '',
                  //"lbl_hnd".tr,
                  buttonStyle: CustomButtonStyles.fillRedTL14,
                  buttonTextStyle: CustomTextStyles.labelLargeGray60004,
                ),
              ],
            ),
            SizedBox(height: 7.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    flightdetailsItemModelObj.departureTime!.value,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Container(
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  padding: EdgeInsets.all(1.h),
                  decoration: AppDecoration.fillPrimary,
                  child: CustomImageView(
                    imagePath:
                        // flightdetailsItemModelObj.logo?.value,
                        ImageConstant.imgUserGray6000416x17,
                    height: 16.v,
                    width: 17.h,
                    alignment: Alignment.center,
                  ),
                ),
                Obx(
                  () => Text(
                    flightdetailsItemModelObj.arrivalTime!.value,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            SizedBox(height: 33.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 1.v),
                  child: Obx(
                    () => Text(
                      flightdetailsItemModelObj.airline!.value,
                      style: CustomTextStyles.titleSmallBlack900,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    flightdetailsItemModelObj.price!.value,
                    style: CustomTextStyles.titleMediumRedA200ExtraBold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
