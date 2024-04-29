import '../../../core/app_export.dart';

/// This class is used in the [frame7_item_widget] screen.
class Frame7ItemModel {
  Frame7ItemModel({
    this.buyGoldPlanText,
    this.loremIpsumDolorText,
    this.id,
  }) {
    buyGoldPlanText = buyGoldPlanText ?? Rx("Buy Gold Plan");
    loremIpsumDolorText =
        loremIpsumDolorText ?? Rx("Lorem ipsum dolor sit amet consectetur. ");
    id = id ?? Rx("");
  }

  Rx<String>? buyGoldPlanText;

  Rx<String>? loremIpsumDolorText;

  Rx<String>? id;
}

enum PlanType { Platinum, Gold, TextTries }
