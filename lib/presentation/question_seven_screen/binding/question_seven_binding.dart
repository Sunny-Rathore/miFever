import '../controller/question_seven_controller.dart';
import 'package:get/get.dart';

/// A binding class for the QuestionSevenScreen.
///
/// This class ensures that the QuestionSevenController is created when the
/// QuestionSevenScreen is first loaded.
class QuestionSevenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionSevenController());
  }
}
