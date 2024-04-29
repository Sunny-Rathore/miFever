import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import 'controller/subscription_plans_controller.dart';
import 'widgets/plans_view.dart';

// ignore_for_file: must_be_immutable
class SubscriptionPlansScreen extends GetWidget<SubscriptionPlansController> {
  SubscriptionPlansScreen({Key? key}) : super(key: key);
  String index = Get.parameters['index'] ?? '';
  @override
  Widget build(BuildContext context) {
    if (index.isNotEmpty) {
      controller.tabViewController.index = int.parse(index);
    }
    return SafeArea(
      child: Obx(
        () => Scaffold(
          backgroundColor: controller.selectedIndex.value == 0
              ? appTheme.lime800
              : appTheme.gray600,
          body: SizedBox(
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 320.h,
                    width: SizeUtils.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          ImageConstant.imgGroup31,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 18.v),
                    _buildTabBar(),
                    SizedBox(
                      height: 694.v,
                      child: TabBarView(
                        controller: controller.tabViewController,
                        children: [
                          PlansView(),
                          PlansView(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage(
      //       ImageConstant.imgGroup31,
      //     ),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Container(
        height: 56.v,
        width: 335.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            28.h,
          ),
          border: Border.all(
            color: theme.colorScheme.primary,
            width: 1.h,
          ),
        ),
        child: TabBar(
          dividerHeight: 0.0,
          indicatorSize: TabBarIndicatorSize.tab,
          controller: controller.tabViewController,
          labelPadding: EdgeInsets.zero,
          labelColor: theme.colorScheme.onPrimary.withOpacity(1),
          labelStyle: TextStyle(
            fontSize: 16.fSize,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelColor: theme.colorScheme.primary,
          unselectedLabelStyle: TextStyle(
            fontSize: 16.fSize,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
          ),
          indicatorPadding: EdgeInsets.all(8.h),
          indicator: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(
              20.h,
            ),
          ),
          tabs: [
            Tab(
              child: Text(
                "lbl_gold_plan".tr,
              ),
            ),
            Tab(
              child: Text(
                "lbl_platinum_plan2".tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
