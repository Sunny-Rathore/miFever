import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/empty_state_page/models/empty_state_model.dart';

/// A controller class for the EmptyStatePage.
///
/// This class manages the state of the EmptyStatePage, including the
/// current emptyStateModelObj
class EmptyStateController extends GetxController {
  EmptyStateController(this.emptyStateModelObj);

  Rx<EmptyStateModel> emptyStateModelObj;
}
