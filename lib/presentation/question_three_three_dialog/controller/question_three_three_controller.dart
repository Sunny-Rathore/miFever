import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/question_three_three_dialog/models/question_three_three_model.dart';

class QuestionThreeThreeController extends GetxController {
  Rx<QuestionThreeThreeModel> questionThreeThreeModelObj =
      QuestionThreeThreeModel().obs;

  Rx<List<DateTime?>> selectedDatesFromCalendar1 = Rx([]);

  SelectionPopupModel? selectedDropDownValue;

  onSelected(dynamic value) {
    for (var element
        in questionThreeThreeModelObj.value.dropdownItemList.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    questionThreeThreeModelObj.value.dropdownItemList.refresh();
  }
}
