import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/tooltips_one_screen/models/tooltips_one_model.dart';

/// A controller class for the TooltipsOneScreen.
///
/// This class manages the state of the TooltipsOneScreen, including the
/// current tooltipsOneModelObj
class TooltipsOneController extends GetxController {
  Rx<TooltipsOneModel> tooltipsOneModelObj = TooltipsOneModel().obs;
}
