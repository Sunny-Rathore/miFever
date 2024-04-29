import '../controller/block_proflie_controller.dart';
import 'package:get/get.dart';

/// A binding class for the BlockProflieScreen.
///
/// This class ensures that the BlockProflieController is created when the
/// BlockProflieScreen is first loaded.
class BlockProflieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BlockProflieController());
  }
}
