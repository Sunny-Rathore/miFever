// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/models/subscriptions/subscription_model.dart';
import 'package:mifever/presentation/subscription_plans_screen/widgets/plan_price_widget.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import '../../../data/sevices/stripe_service.dart';
import '../../subscription_plans_page/models/subscription_plans_model.dart';
import '../controller/subscription_plans_controller.dart';

class PlansView extends StatelessWidget {
  PlansView({Key? key}) : super(key: key);

  SubscriptionPlansController controller =
      Get.put(SubscriptionPlansController(SubscriptionPlansModel().obs));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // backgroundColor: theme.colorScheme.onPrimary.withOpacity(1),
        body: Container(
          width: double.maxFinite,
          color: Colors.transparent,
          //decoration: AppDecoration.fillOnPrimary,
          child: Column(
            children: [
              SizedBox(height: 24.v),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: controller.selectedIndex.value == 1
                        ? ImageConstant.imgPlatinum
                        : ImageConstant.imgGroup25Gray900112x112,
                    height: 112.adaptSize,
                    width: 112.adaptSize,
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: 15.v),
                  Align(
                    alignment: Alignment.center,
                    child: Obx(
                      () => Text(
                        controller.selectedIndex.value == 1
                            ? "lbl_platinum_plan".tr
                            : "lbl_gold_plan".tr,
                        style: CustomTextStyles.headlineSmallPrimary,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.v),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      controller.selectedIndex.value == 1
                          ? "lbl_get_platinum_push".tr
                          : "lbl_get_your_gold".tr,
                      style: CustomTextStyles.bodyMediumPrimary,
                    ),
                  ),
                  SizedBox(height: 22.v),
                  Obx(
                    () => _buildPlanFeature(
                      controller.selectedIndex.value == 1
                          ? controller.subscriptionPlansModelObj.value
                              .plansFeatureListPlatinum
                          : controller.subscriptionPlansModelObj.value
                              .plansFeatureListGold,
                    ),
                  ),
                  SizedBox(height: 24.v),
                  Obx(
                    () => _buildFrame(
                      controller.selectedIndex.value == 1
                          ? controller
                              .subscriptionPlansModelObj.value.plansListPlatinum
                          : controller
                              .subscriptionPlansModelObj.value.plansListGold,
                    ),
                  ),
                  SizedBox(height: 61.v),
                  CustomElevatedButton(
                    text: "lbl_continue".tr,
                    margin: EdgeInsets.symmetric(horizontal: 20.h),
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    buttonTextStyle: TextStyle(color: Colors.black),
                    alignment: Alignment.center,
                    onPressed: () async {
                      if (controller
                          .selectedPlanModel.value.id!.value.isEmpty) {
                        Fluttertoast.showToast(msg: 'Select plan');
                      } else {
                        SubscriptionModel subscriptionModel = SubscriptionModel(
                          userId: PrefUtils.getId(),
                          plan: controller.selectedPlanModel.value,
                          timestamp: DateTime.now().toUtc().toString(),
                          expireTimestamp: getExpireTimestamp(controller
                              .selectedPlanModel.value.duration!.value),
                        );
                        await StripePaymentHandle.stripeMakePayment(
                            subscriptionModel);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getExpireTimestamp(String duration) {
    if (duration == '1 Week') {
      return DateTime.now().add(Duration(days: 7)).toString();
    } else if (duration == '3 months') {
      return DateTime.now().add(Duration(days: 90)).toString();
    } else if (duration == '6 months') {
      return DateTime.now().add(Duration(days: 180)).toString();
    } else if (duration == '1 Year') {
      return DateTime.now().add(Duration(days: 360)).toString();
    } else {
      return '';
    }
  }

  Obx _buildPlanFeature(Rx<List<PlansModelFeature>> list) {
    return Obx(
      () => Column(
        children: List.generate(
          list.value.length,
          (index) => Opacity(
            opacity: list.value[index].isEnable!.value ? 1 : 0.4,
            child: Padding(
              padding: EdgeInsets.only(left: 30.h, bottom: 13.v),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: list.value[index].isEnable!.value
                        ? ImageConstant.imgCheckmarkCircle02Primary
                        : ImageConstant.imgRemoveCircle,
                    height: 18.adaptSize,
                    width: 18.adaptSize,
                    margin: EdgeInsets.only(bottom: 1.v),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 6.h,
                      top: 2.v,
                    ),
                    child: Text(
                      list.value[index].title!.value,
                      style: CustomTextStyles.labelLargePrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrame(Rx<List<PlansModel>> list) {
    return SizedBox(
      height: 137.v,
      child: Obx(
        () => ListView.separated(
          padding: EdgeInsets.only(left: 12.h),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              width: 12.h,
            );
          },
          itemCount: list.value.length,
          itemBuilder: (context, index) {
            PlansModel model = list.value[index];
            return PlanPriceWidget(
              model,
            );
          },
        ),
      ),
    );
  }
}
