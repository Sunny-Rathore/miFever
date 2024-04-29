import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/liked_one_screen/models/liked_one_model.dart';

/// A controller class for the LikedOneScreen.
///
/// This class manages the state of the LikedOneScreen, including the
/// current likedOneModelObj
class LikedOneController extends GetxController {
  Rx<LikedOneModel> likedOneModelObj = LikedOneModel().obs;
}
