import 'package:get/get.dart';

import '../controller/question_three_controller.dart';

/// A binding class for the QuestionThreeOneScreen.
///
/// This class ensures that the QuestionThreeOneController is created when the
/// QuestionThreeOneScreen is first loaded.
class QuestionThreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionThreeController());
  }
}
