import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/question_six_screen/models/question_six_model.dart';

/// A controller class for the QuestionSixScreen.
///
/// This class manages the state of the QuestionSixScreen, including the
/// current questionSixModelObj
class QuestionSixController extends GetxController {
  Rx<QuestionSixModel> questionSixModelObj = QuestionSixModel().obs;

  Rx<String> whatDoYouWantToFindOut = "".obs;

  List whatDoYouWantToFindOutList = [
    "lbl_casual_dating".tr,
    "msg_serious_relationship".tr,
    "msg_culture_learning".tr,
    "lbl_i_don_t_know".tr,
  ];
}
