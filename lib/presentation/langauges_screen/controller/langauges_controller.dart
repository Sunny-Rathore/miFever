import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/langauges_screen/models/langauges_model.dart';

import '../models/language_options_widgetModel.dart';

class LangaugesController extends GetxController {
  Rx<LangaugesModel> langaugesModelObj = LangaugesModel().obs;

  //var selectedLanguage = 'English'.tr.obs;

  Rx<LanguageOptionsWidgetModel> languageModel =
      LanguageOptionsWidgetModel(id: Rx('es'), englishText: "Spanish".obs).obs;

  @override
  void onInit() {
    String lang = PrefUtils.getLang();
    print('lang==>$lang');
    if (lang == 'en') {
      LanguageOptionsWidgetModel model =
          langaugesModelObj.value.languageOptionsList.value[0];
      languageModel.value = model;
    } else if (lang == 'es') {
      LanguageOptionsWidgetModel model =
          langaugesModelObj.value.languageOptionsList.value[1];
      languageModel.value = model;
    } else if (lang == 'pt') {
      LanguageOptionsWidgetModel model =
          langaugesModelObj.value.languageOptionsList.value[2];
      languageModel.value = model;
    }
    super.onInit();
  }
}
