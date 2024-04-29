import '../controller/langauges_controller.dart';
import 'package:get/get.dart';

/// A binding class for the LangaugesScreen.
///
/// This class ensures that the LangaugesController is created when the
/// LangaugesScreen is first loaded.
class LangaugesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LangaugesController());
  }
}
