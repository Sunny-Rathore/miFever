// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/subscription_plans_screen/widgets/plan_price_widget.dart';

import '../../data/models/subscriptions/subscription_model.dart';
import '../../data/sevices/stripe_service.dart';
import '../../widgets/custom_elevated_button.dart';
import '../subscription_plans_page/models/subscription_plans_model.dart';
import '../subscription_plans_screen/controller/subscription_plans_controller.dart';

class TextTriesPage extends StatelessWidget {
  TextTriesPage({Key? key}) : super(key: key);

  SubscriptionPlansController controller =
      Get.put(SubscriptionPlansController(SubscriptionPlansModel().obs));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF92163A),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.only(right: 24.h, top: 24.v),
                padding: EdgeInsets.all(5.h),
                decoration: BoxDecoration(
                    color: Colors.white38, shape: BoxShape.circle),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              CustomImageView(
                // height: 112.adaptSize,
                // width: 112.adaptSize,
                imagePath: ImageConstant.imgGroup31,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60.v),
                  CustomImageView(
                    imagePath: 'assets/images/text_tries.svg',
                    height: 112.adaptSize,
                    width: 112.adaptSize,
                    alignment: Alignment.center,
                  ),
                  // SizedBox(height: 15.v),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'lbl_text_tries'.tr,
                      style: CustomTextStyles.headlineSmallPrimary,
                    ),
                  ),
                  SizedBox(height: 4.v),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.h),
                      child: Text(
                        'lbl_according_to_plan'.tr,
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.bodyMediumPrimary,
                      ),
                    ),
                  ),
                  SizedBox(height: 22.v),
                ],
              ),
            ],
          ),
          _buildFrame(
              controller.subscriptionPlansModelObj.value.plansListTexTries),
          CustomElevatedButton(
            text: "lbl_continue".tr,
            margin: EdgeInsets.symmetric(horizontal: 20.h),
            buttonStyle: CustomButtonStyles.fillPrimary,
            buttonTextStyle: TextStyle(color: Colors.black),
            alignment: Alignment.center,
            onPressed: () async {
              if (controller.selectedPlanModel.value.id!.value.isEmpty) {
                Fluttertoast.showToast(msg: 'Select plan');
              } else {
                SubscriptionModel subscriptionModel = SubscriptionModel(
                  userId: PrefUtils.getId(),
                  plan: controller.selectedPlanModel.value,
                  timestamp: DateTime.now().toString(),
                  expireTimestamp: getExpireTimestamp(
                      controller.selectedPlanModel.value.duration!.value),
                );
                await StripePaymentHandle.stripeMakePayment(subscriptionModel);
              }
            },
          ),
        ],
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
