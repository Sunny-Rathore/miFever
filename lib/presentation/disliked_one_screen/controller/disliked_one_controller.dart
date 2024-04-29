import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/disliked_one_screen/models/disliked_one_model.dart';

/// A controller class for the DislikedOneScreen.
///
/// This class manages the state of the DislikedOneScreen, including the
/// current dislikedOneModelObj
class DislikedOneController extends GetxController {
  Rx<DislikedOneModel> dislikedOneModelObj = DislikedOneModel().obs;
}
