import '../controller/block_proflie_one_controller.dart';
import 'package:get/get.dart';

/// A binding class for the BlockProflieOneScreen.
///
/// This class ensures that the BlockProflieOneController is created when the
/// BlockProflieOneScreen is first loaded.
class BlockProflieOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BlockProflieOneController());
  }
}
