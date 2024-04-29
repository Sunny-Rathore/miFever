import '../controller/filter_appled_container_controller.dart';
import 'package:get/get.dart';

/// A binding class for the FilterAppledContainerScreen.
///
/// This class ensures that the FilterAppledContainerController is created when the
/// FilterAppledContainerScreen is first loaded.
class FilterAppledContainerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterAppledContainerController());
  }
}
