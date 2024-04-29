import 'package:get/get.dart';

import '../controller/question_one_controller.dart';

/// A binding class for the QuestionOneTwoScreen.
///
/// This class ensures that the QuestionOneTwoController is created when the
/// QuestionOneTwoScreen is first loaded.
class QuestionOneTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionOneController());
  }
}
