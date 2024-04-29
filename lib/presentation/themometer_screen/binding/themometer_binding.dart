import '../controller/themometer_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ThemometerScreen.
///
/// This class ensures that the ThemometerController is created when the
/// ThemometerScreen is first loaded.
class ThemometerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemometerController());
  }
}
