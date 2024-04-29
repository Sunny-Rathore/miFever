import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/empty_state_one_page/models/empty_state_one_model.dart';

/// A controller class for the EmptyStateOnePage.
///
/// This class manages the state of the EmptyStateOnePage, including the
/// current emptyStateOneModelObj
class EmptyStateOneController extends GetxController {
  EmptyStateOneController(this.emptyStateOneModelObj);

  Rx<EmptyStateOneModel> emptyStateOneModelObj;
}
