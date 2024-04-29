import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/block_proflie_one_screen/models/block_proflie_one_model.dart';

/// A controller class for the BlockProflieOneScreen.
///
/// This class manages the state of the BlockProflieOneScreen, including the
/// current blockProflieOneModelObj
class BlockProflieOneController extends GetxController {
  Rx<BlockProflieOneModel> blockProflieOneModelObj = BlockProflieOneModel().obs;

  Rx<String> selectReasonWhyYouWantToBlockJ = "".obs;
}
