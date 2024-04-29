import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../../subscription_plans_page/models/subscription_plans_model.dart';

class SubscriptionPlansController extends GetxController
    with GetSingleTickerProviderStateMixin {
  SubscriptionPlansController(this.subscriptionPlansModelObj);
  Rx<SubscriptionPlansModel> subscriptionPlansModelObj;
  late TabController tabViewController;
  RxInt selectedIndex = 0.obs;
  Rx<PlansModel> selectedPlanModel = PlansModel().obs;
  @override
  void onInit() {
    tabViewController = Get.put(TabController(vsync: this, length: 2));
    tabViewController.addListener(() {
      selectedIndex.value = tabViewController.index;
      selectedPlanModel.value = PlansModel();
    });
    super.onInit();
  }
}
