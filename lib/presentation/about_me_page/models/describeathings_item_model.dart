import '../../../core/app_export.dart';

/// This class is used in the [describeathings_item_widget] screen.
class DescribeathingsItemModel {
  DescribeathingsItemModel({
    this.question,
    this.answer,
    this.key,
  }) {
    question = question ?? Rx("Describe a Things You really like to do");
    answer = answer ?? Rx("");
    key = key ?? Rx('');
  }

  Rx<String>? question;

  Rx<String>? answer;

  Rx<String>? key;
}
