import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/match_screen/models/match_model.dart';

/// A controller class for the MatchScreen.
///
/// This class manages the state of the MatchScreen, including the
/// current matchModelObj
class MatchController extends GetxController {
  Rx<MatchModel> matchModelObj = MatchModel().obs;
}
