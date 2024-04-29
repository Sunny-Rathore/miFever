import '../controller/question_two_controller.dart';
import 'package:get/get.dart';

/// A binding class for the QuestionTwoScreen.
///
/// This class ensures that the QuestionTwoController is created when the
/// QuestionTwoScreen is first loaded.
class QuestionTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionTwoController());
  }
}
