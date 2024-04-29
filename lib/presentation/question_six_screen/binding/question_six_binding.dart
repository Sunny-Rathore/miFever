import '../controller/question_six_controller.dart';
import 'package:get/get.dart';

/// A binding class for the QuestionSixScreen.
///
/// This class ensures that the QuestionSixController is created when the
/// QuestionSixScreen is first loaded.
class QuestionSixBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionSixController());
  }
}
