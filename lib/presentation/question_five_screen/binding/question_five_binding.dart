import '../controller/question_five_controller.dart';
import 'package:get/get.dart';

/// A binding class for the QuestionFiveScreen.
///
/// This class ensures that the QuestionFiveController is created when the
/// QuestionFiveScreen is first loaded.
class QuestionFiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionFiveController());
  }
}
