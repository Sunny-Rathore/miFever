import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/disliked_screen/models/disliked_model.dart';

/// A controller class for the DislikedScreen.
///
/// This class manages the state of the DislikedScreen, including the
/// current dislikedModelObj
class DislikedController extends GetxController {
  Rx<DislikedModel> dislikedModelObj = DislikedModel().obs;
}
