import 'package:mifever/core/app_export.dart';

import '../../question_three_dialog/models/question_three_model.dart';

class QuestionThreeController extends GetxController {
  Rx<QuestionThreeModel> questionThreeOneModelObj = QuestionThreeModel().obs;
  Rx<DateTime> initialDateTime =
      DateTime.now().subtract(Duration(days: 18 * 366)).obs;
  var selectedDate =
      DateTime.now().subtract(Duration(days: 18 * 366)).format().obs;
  var previousSelected =
      DateTime.now().subtract(Duration(days: 18 * 366)).format().obs;
}
