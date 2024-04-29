import '../controller/flight_recommendation_controller.dart';
import 'package:get/get.dart';

/// A binding class for the FlightRecommendationScreen.
///
/// This class ensures that the FlightRecommendationController is created when the
/// FlightRecommendationScreen is first loaded.
class FlightRecommendationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FlightRecommendationController());
  }
}
