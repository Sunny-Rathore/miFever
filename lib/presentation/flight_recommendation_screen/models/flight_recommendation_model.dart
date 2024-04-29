import '../../../core/app_export.dart';
import 'flightdetails_item_model.dart';

/// This class defines the variables used in the [flight_recommendation_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class FlightRecommendationModel {
  Rx<List<FlightdetailsItemModel>> flightdetailsItemList = Rx([
    FlightdetailsItemModel(
        hrsStop: "13:00 Hrs • 1 Stop".obs,
        departureTime: "09:00".obs,
        arrivalTime: "22:00".obs,
        airline: "Garuda Air".obs,
        price: "250".obs),
    FlightdetailsItemModel(
        hrsStop: "13:00 Hrs • 2 Stop".obs,
        departureTime: "15:50".obs,
        arrivalTime: "10:45".obs,
        airline: "Singapore Airlines".obs,
        price: "450".obs),
    FlightdetailsItemModel(
        hrsStop: "13:00 Hrs • 2 Stop".obs,
        departureTime: "12:20".obs,
        arrivalTime: "10:45".obs,
        airline: "ANA All Nippon Airways".obs,
        price: "500".obs),
    FlightdetailsItemModel(
        hrsStop: "13:00 Hrs • 2 Stop".obs,
        departureTime: "15:50".obs,
        arrivalTime: "10:45".obs,
        airline: "Garuda Air".obs,
        price: "250".obs)
  ]);
}
