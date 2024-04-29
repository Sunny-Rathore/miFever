import '../controller/question_four_controller.dart';
import 'package:get/get.dart';

/// A binding class for the QuestionFourScreen.
///
/// This class ensures that the QuestionFourController is created when the
/// QuestionFourScreen is first loaded.
class QuestionFourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionFourController());
  }
}
