import '../../../core/app_export.dart';
import 'language_options_widgetModel.dart';

/// This class defines the variables used in the [langauges_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class LangaugesModel {
  Rx<List<LanguageOptionsWidgetModel>> languageOptionsList = Rx([
    LanguageOptionsWidgetModel(id: Rx('en'), englishText: "English".obs),
    LanguageOptionsWidgetModel(id: Rx('es'), englishText: "Spanish".obs),
    LanguageOptionsWidgetModel(id: Rx('pt'), englishText: "Portuguese".obs)
  ]);
}
