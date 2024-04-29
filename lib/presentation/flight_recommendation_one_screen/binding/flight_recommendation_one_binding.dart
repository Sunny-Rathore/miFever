import '../controller/flight_recommendation_one_controller.dart';
import 'package:get/get.dart';

/// A binding class for the FlightRecommendationOneScreen.
///
/// This class ensures that the FlightRecommendationOneController is created when the
/// FlightRecommendationOneScreen is first loaded.
class FlightRecommendationOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FlightRecommendationOneController());
  }
}
