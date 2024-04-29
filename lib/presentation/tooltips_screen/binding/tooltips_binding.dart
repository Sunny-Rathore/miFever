import '../controller/tooltips_controller.dart';
import 'package:get/get.dart';

/// A binding class for the TooltipsScreen.
///
/// This class ensures that the TooltipsController is created when the
/// TooltipsScreen is first loaded.
class TooltipsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TooltipsController());
  }
}
