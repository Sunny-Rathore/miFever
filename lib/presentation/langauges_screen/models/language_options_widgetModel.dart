import '../../../core/app_export.dart';

class LanguageOptionsWidgetModel {
  LanguageOptionsWidgetModel({
    this.englishText,
    this.id,
  }) {
    englishText = englishText ?? Rx("English");
    id = id ?? Rx("en");
  }

  Rx<String>? englishText;

  Rx<String>? id;
}
