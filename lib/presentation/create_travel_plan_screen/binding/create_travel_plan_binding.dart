import '../controller/create_travel_plan_controller.dart';
import 'package:get/get.dart';

/// A binding class for the CreateTravelPlanScreen.
///
/// This class ensures that the CreateTravelPlanController is created when the
/// CreateTravelPlanScreen is first loaded.
class CreateTravelPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateTravelPlanController());
  }
}
