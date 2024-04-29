import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/question_four_screen/models/question_four_model.dart';

/// A controller class for the QuestionFourScreen.
///
/// This class manages the state of the QuestionFourScreen, including the
/// current questionFourModelObj
class QuestionFourController extends GetxController {
  Rx<QuestionFourModel> questionFourModelObj = QuestionFourModel().obs;
  var selectedInterest = ''.obs;
  var selectedInterestList = [].obs;
}
