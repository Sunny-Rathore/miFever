import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/match_screen_three_screen/models/match_screen_three_model.dart';

/// A controller class for the MatchScreenThreeScreen.
///
/// This class manages the state of the MatchScreenThreeScreen, including the
/// current matchScreenThreeModelObj
class MatchScreenThreeController extends GetxController {
  Rx<MatchScreenThreeModel> matchScreenThreeModelObj =
      MatchScreenThreeModel().obs;
}
