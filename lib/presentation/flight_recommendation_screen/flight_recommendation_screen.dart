import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';

import '../flight_recommendation_one_screen/models/fliter_model.dart';
import 'controller/flight_recommendation_controller.dart';
import 'models/flightdetails_item_model.dart';
import 'widgets/flightdetails_item_widget.dart';

// ignore_for_file: must_be_immutable
class FlightRecommendationScreen
    extends GetWidget<FlightRecommendationController> {
  FlightRecommendationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 27.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${controller.fliteModel.length} ' + "lbl_12_flights".tr,
                  style: CustomTextStyles.titleMediumGray900ExtraBold,
                ),
                SizedBox(height: 10.v),
                _buildFlightDetails(controller.fliteModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Get.back();
        },
        imagePath: ImageConstant.imgArrowLeft02SharpGray90024x24,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 16.v,
          bottom: 16.v,
        ),
      ),
      title: AppbarSubtitle(
        text:
            "${controller.pickLocationController.text} to ${controller.dropLocationToController.text}",
        //"msg_jakarta_to_tokyo".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildFlightDetails(List<FliteModel> list) {
    return Obx(
      () => ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.v),
            child: SizedBox(
              width: 190.h,
              child: Divider(
                height: 1.v,
                thickness: 1.v,
                color: appTheme.gray60004,
              ),
            ),
          );
        },
        itemCount: list.length,
        itemBuilder: (context, index) {
          return FlightdetailsItemWidget(
            FlightdetailsItemModel(
                hrsStop:
                    '${formatMinutesToHours(list[index].legs?[0].durationInMinutes ?? 0)} Hrs • ${list[index].legs?[0].stopCount.toString()}  Stop'
                        .obs,
                departureTime: convertUtcToLocal(
                        list[index].legs?[0].departure ?? DateTime.now())
                    .obs,
                arrivalTime: convertUtcToLocal(
                        list[index].legs?[0].arrival ?? DateTime.now())
                    .obs,
                airline: list[index]
                    .legs?[0]
                    .carriers
                    ?.marketing?[0]
                    .name
                    .toString()
                    .obs,
                disPlayCodeOrigin:
                    list[index].legs?[0].origin?.displayCode.toString().obs,
                disPlayCodeDestination: list[index]
                    .legs?[0]
                    .destination
                    ?.displayCode
                    .toString()
                    .obs,
                logo: list[index]
                    .legs?[0]
                    .carriers
                    ?.marketing?[0]
                    .logoUrl
                    .toString()
                    .obs,
                price: list[index].price?.formatted.toString().obs),
          );
        },
      ),
    );
  }
}
