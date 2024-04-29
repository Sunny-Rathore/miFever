import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/new_post_screen/models/new_post_model.dart';

/// A controller class for the NewPostScreen.
///
/// This class manages the state of the NewPostScreen, including the
/// current newPostModelObj
class NewPostController extends GetxController {
  Rx<NewPostModel> newPostModelObj = NewPostModel().obs;
}
