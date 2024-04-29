import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/tooltips_screen/models/tooltips_model.dart';

/// A controller class for the TooltipsScreen.
///
/// This class manages the state of the TooltipsScreen, including the
/// current tooltipsModelObj
class TooltipsController extends GetxController {
  Rx<TooltipsModel> tooltipsModelObj = TooltipsModel().obs;
}
