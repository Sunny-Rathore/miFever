import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/flight_recommendation_one_screen/models/flight_recommendation_one_model.dart';

class FlightRecommendationOneController extends GetxController {
  Rx<FlightRecommendationOneModel> flightRecommendationOneModelObj =
      FlightRecommendationOneModel().obs;
}
