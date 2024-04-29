import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/question_one_one_dialog/models/question_one_one_model.dart';

/// A controller class for the QuestionOneOneDialog.
///
/// This class manages the state of the QuestionOneOneDialog, including the
/// current questionOneOneModelObj
class QuestionOneOneController extends GetxController {
  Rx<QuestionOneOneModel> questionOneOneModelObj = QuestionOneOneModel().obs;
}
