import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/question_two_screen/models/question_two_model.dart';

class QuestionTwoController extends GetxController {
  Rx<QuestionTwoModel> questionTwoModelObj = QuestionTwoModel().obs;
  var selectedGender = ''.obs;
}
