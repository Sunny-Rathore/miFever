import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/subscription_plans_screen/controller/subscription_plans_controller.dart';

import '../../subscription_plans_page/models/subscription_plans_model.dart';

// ignore: must_be_immutable
class PlanPriceWidget extends StatelessWidget {
  PlanPriceWidget(this.planModel, {Key? key}) : super(key: key);

  PlansModel planModel;

  var controller = Get.find<SubscriptionPlansController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Obx(
        () => GestureDetector(
          onTap: () {
            controller.selectedPlanModel.value = planModel;
          },
          child: SizedBox(
            width: 94.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  // height: 99.v,
                  width: 94.h,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 95.v,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.h,
                            vertical: 18.v,
                          ),
                          decoration:
                              controller.selectedPlanModel.value == planModel
                                  ? AppDecoration.outlinePrimary2.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder9,
                                    )
                                  : AppDecoration.outlinePrimary1.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder9,
                                    ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Text(
                                  planModel.amount!.value,
                                  style: theme.textTheme.titleLarge,
                                ),
                              ),
                              SizedBox(height: 4.v),
                              Obx(
                                () => Text(
                                  planModel.duration!.value,
                                  style: CustomTextStyles.labelLargeGray200,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /*-------discount----------*/
                      Positioned(
                        top: -8.h,
                        child: Container(
                          alignment: Alignment.center,
                          width: 67.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.h,
                            vertical: 4.v,
                          ),
                          decoration:
                              controller.selectedPlanModel.value == planModel
                                  ? AppDecoration.fillGray200.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder9,
                                    )
                                  : AppDecoration.fillGray900.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder9,
                                    ),
                          child: Obx(
                            () => Text(
                              planModel.savings!.value,
                              style: theme.textTheme.labelMedium!.copyWith(
                                color: controller.selectedPlanModel.value ==
                                        planModel
                                    ? appTheme.lime800
                                    : theme.colorScheme.primary,
                                fontSize: 10.fSize,
                              ),
                              //CustomTextStyles.labelMediumPrimary10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //SizedBox(height: 8.v),
                Obx(
                  () => Radio(
                      activeColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith((states) =>
                          controller.selectedPlanModel.value == planModel
                              ? Colors.white
                              : Colors.white.withOpacity(0.4)),
                      value: controller.selectedPlanModel.value == planModel,
                      groupValue: true,
                      onChanged: null),
                )
                // Container(
                //   height: 20.adaptSize,
                //   width: 20.adaptSize,
                //   margin: EdgeInsets.only(left: 34.h),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(
                //       10.h,
                //     ),
                //     border: Border.all(
                //       color: theme.colorScheme.primary.withOpacity(0.3),
                //       width: 1.h,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
