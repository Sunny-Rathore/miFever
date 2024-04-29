import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/liked_screen/models/liked_model.dart';

/// A controller class for the LikedScreen.
///
/// This class manages the state of the LikedScreen, including the
/// current likedModelObj
class LikedController extends GetxController {
  Rx<LikedModel> likedModelObj = LikedModel().obs;
}
