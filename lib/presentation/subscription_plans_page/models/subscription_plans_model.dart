// ignore_for_file: sdk_version_since

import 'package:mifever/presentation/my_profile_screen/models/frame7_item_model.dart';

import '../../../core/app_export.dart';

/// This class defines the variables used in the [subscription_plans_page],
/// and is typically used to hold data that is passed between different parts of the application.
class SubscriptionPlansModel {
  Rx<List<PlansModelFeature>> plansFeatureListPlatinum = Rx([
    PlansModelFeature(
        title: "msg_limited_user_profile".tr.obs, isEnable: true.obs),
    PlansModelFeature(
        title: "msg_25_chances_to_message".tr.obs, isEnable: true.obs),
    PlansModelFeature(title: "lbl_unlimited_likes".tr.obs, isEnable: true.obs),
    PlansModelFeature(
        title: "msg_see_who_likes_you".tr.obs, isEnable: true.obs),
    PlansModelFeature(
        title: "msg_push_your_profile".tr.obs, isEnable: true.obs),
    PlansModelFeature(title: "msg_full_access_user".tr.obs, isEnable: true.obs),
  ]);

  Rx<List<PlansModelFeature>> plansFeatureListGold = Rx([
    PlansModelFeature(
        title: "msg_limited_user_profile".tr.obs, isEnable: true.obs),
    PlansModelFeature(
        title: "msg_25_chances_to_message".tr.obs, isEnable: true.obs),
    PlansModelFeature(title: "lbl_unlimited_likes".tr.obs, isEnable: true.obs),
    PlansModelFeature(
        title: "msg_see_who_likes_you".tr.obs, isEnable: true.obs),
    PlansModelFeature(
        title: "msg_push_your_profile".tr.obs, isEnable: false.obs),
    PlansModelFeature(
        title: "msg_full_access_user".tr.obs, isEnable: false.obs),
  ]);

  Rx<List<PlansModel>> plansListPlatinum = Rx([
    PlansModel(
        id: PlanType.Platinum.name.obs,
        amount: " \$10".obs,
        duration: "1 Week".obs,
        savings: "20% Save".obs),
    PlansModel(
        id: PlanType.Platinum.name.obs,
        amount: " \$20".obs,
        duration: "3 Months".obs,
        savings: "20% Save".obs),
    PlansModel(
        id: PlanType.Platinum.name.obs,
        amount: " \$30".obs,
        duration: "6 Months".obs,
        savings: "30% Save".obs),
    PlansModel(
        id: PlanType.Platinum.name.obs,
        amount: " \$50".obs,
        duration: "1 Year".obs,
        savings: "40% Save".obs)
  ]);

  Rx<List<PlansModel>> plansListGold = Rx([
    PlansModel(
        id: PlanType.Gold.name.obs,
        amount: " \$10".obs,
        duration: "1 Week".obs,
        savings: "20% Save".obs),
    PlansModel(
        id: PlanType.Gold.name.obs,
        amount: " \$20".obs,
        duration: "3 Months".obs,
        savings: "20% Save".obs),
    PlansModel(
        id: PlanType.Gold.name.obs,
        amount: " \$30".obs,
        duration: "6 Months".obs,
        savings: "30% Save".obs),
    PlansModel(
        id: PlanType.Gold.name.obs,
        amount: " \$50".obs,
        duration: "1 Year".obs,
        savings: "40% Save".obs)
  ]);
  Rx<List<PlansModel>> plansListTexTries = Rx([
    PlansModel(
        id: PlanType.TextTries.name.obs,
        amount: " \$10".obs,
        duration: "25 Chances".obs,
        savings: "20% Save".obs),
    PlansModel(
        id: PlanType.TextTries.name.obs,
        amount: " \$20".obs,
        duration: "55 Chances".obs,
        savings: "20% Save".obs),
    PlansModel(
        id: PlanType.TextTries.name.obs,
        amount: " \$30".obs,
        duration: "85 Chances".obs,
        savings: "30% Save".obs),
    PlansModel(
        id: PlanType.TextTries.name.obs,
        amount: " \$50".obs,
        duration: "125 Chances".obs,
        savings: "40% Save".obs)
  ]);
}

/// This class is used in the [userprofile3_item_widget] screen.
class PlansModel {
  PlansModel({
    this.amount,
    this.duration,
    this.savings,
    this.id,
  }) {
    amount = amount ?? Rx(" 20");
    duration = duration ?? Rx("3 Months");
    savings = savings ?? Rx("20% Save");
    id = id ?? Rx("");
  }

  Rx<String>? amount;

  Rx<String>? duration;

  Rx<String>? savings;

  Rx<String>? id;

  factory PlansModel.fromJson(Map<String, dynamic> json) {
    return PlansModel(
      amount: Rx<String>(json['amount'] ?? " 20"),
      duration: Rx<String>(json['duration'] ?? "3 Months"),
      savings: Rx<String>(json['savings'] ?? "20% Save"),
      id: Rx<String>(json['id'] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount?.value ?? " 20",
      'duration': duration?.value ?? "3 Months",
      'savings': savings?.value ?? "20% Save",
      'id': id?.value ?? "",
    };
  }
}

class PlansModelFeature {
  PlansModelFeature({
    this.isEnable,
    this.title,
  }) {
    isEnable = isEnable ?? Rx(true);
    title = title ?? Rx("");
  }

  Rx<bool>? isEnable;

  Rx<String>? title;
}
