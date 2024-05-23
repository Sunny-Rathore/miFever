import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';

class LocationService {
  // Function to retrieve the user's current location
  static void getLocationAndSave() async {
    try {
      // Request permission to access the user's location
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Geolocator.requestPermission();
      } else if (permission == LocationPermission.deniedForever) {
        Geolocator.requestPermission();
      } else {
        // Get the current position
        try {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          UserModel userModel = UserModel(
              currentLocationLatLng:
                  GeoPoint(position.latitude, position.longitude));
          FirebaseServices.updateUser(userModel);
        } catch (e) {
          log('Error during save location', error: e);
        }
      }
    } catch (e) {
      log('Error during get location:', error: e);
    }
  }

  static Future<GeoPoint> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return GeoPoint(position.latitude, position.longitude);
    } catch (e) {
      log('Error during save location', error: e);
      return GeoPoint(0, 0);
    }
  }
}
