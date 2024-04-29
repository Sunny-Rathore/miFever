import '../controller/tooltips_one_controller.dart';
import 'package:get/get.dart';

/// A binding class for the TooltipsOneScreen.
///
/// This class ensures that the TooltipsOneController is created when the
/// TooltipsOneScreen is first loaded.
class TooltipsOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TooltipsOneController());
  }
}
