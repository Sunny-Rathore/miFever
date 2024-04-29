import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/filter_appled_page/models/filter_appled_model.dart';

/// A controller class for the FilterAppledPage.
///
/// This class manages the state of the FilterAppledPage, including the
/// current filterAppledModelObj
class FilterAppledController extends GetxController {
  FilterAppledController(this.filterAppledModelObj);

  Rx<FilterAppledModel> filterAppledModelObj;
}
