import '../../../core/app_export.dart';

/// This class is used in the [flightdetails_item_widget] screen.
class FlightdetailsItemModel {
  FlightdetailsItemModel({
    this.hrsStop,
    this.departureTime,
    this.arrivalTime,
    this.airline,
    this.price,
    this.id,
    this.disPlayCodeOrigin,
    this.disPlayCodeDestination,
    this.logo,
  }) {
    hrsStop = hrsStop ?? Rx("13:00 Hrs • 1 Stop");
    departureTime = departureTime ?? Rx("09:00");
    arrivalTime = arrivalTime ?? Rx("22:00");
    airline = airline ?? Rx("Garuda Air");
    price = price ?? Rx("250");
    id = id ?? Rx("");
    disPlayCodeOrigin = disPlayCodeOrigin ?? Rx('');
    disPlayCodeDestination = disPlayCodeDestination ?? Rx('');
    logo = logo ?? Rx('');
  }
  Rx<String>? logo;

  Rx<String>? disPlayCodeOrigin;

  Rx<String>? disPlayCodeDestination;

  Rx<String>? hrsStop;

  Rx<String>? departureTime;

  Rx<String>? arrivalTime;

  Rx<String>? airline;

  Rx<String>? price;

  Rx<String>? id;
}
