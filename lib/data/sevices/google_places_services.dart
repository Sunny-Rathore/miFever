import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:geocoding/geocoding.dart' as get_cord_address;
import 'package:google_api_headers/google_api_headers.dart';
import 'package:location/location.dart' as location;
import 'package:location/location.dart';
import 'package:mifever/core/app_export.dart';

class GooglePlacesApiServices {
  static Future<PlacesDetailsResponse?> placeSelectAPI(
      BuildContext context, String startText) async {
    Prediction? p = await PlacesAutocomplete.show(
      textStyle: TextStyle(color: Colors.black),
      context: context,
      apiKey: "AIzaSyBMNUxVT1By8WKruZvhdhX0IUBaxCHWNGI",
      mode: Mode.fullscreen,
      onError: (response) {
        log("-->${response.status}");
      },
      language: 'fr',
      resultTextStyle: theme.textTheme.titleSmall,
      types: [],
      strictbounds: false,
      components: [],
      startText: startText,
      cursorColor: Colors.black,
    );
    return displayPrediction(p!);
  }

  static Future<PlacesDetailsResponse?> displayPrediction(Prediction? p) async {
    if (p != null) {
      GoogleMapsPlaces? places = GoogleMapsPlaces(
        apiKey: "AIzaSyBMNUxVT1By8WKruZvhdhX0IUBaxCHWNGI",
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse? detail =
          await places.getDetailsByPlaceId(p.placeId.toString());
      return detail;
    }
    return null;
  }

  static final location.Location currentLocation = location.Location();

  static Future<String> getCurrentLocation() async {
    try {
      LocationData location = await currentLocation.getLocation();
      List<get_cord_address.Placemark> placeMarks =
          await get_cord_address.placemarkFromCoordinates(
              location.latitude ?? 0.0, location.longitude ?? 0.0);

      final String address = (placeMarks.first.country!.isEmpty
          ? ''
          : "${placeMarks.first.country}, ");

      return address;
    } catch (e) {
      log('getCurrentLocation', error: e);
      return '';
    }
  }

  static Future<GeoPoint> getLatLongFromAddress(String address) async {
    try {
      List<get_cord_address.Location> locations =
          await get_cord_address.locationFromAddress(address);
      if (locations.isNotEmpty) {
        print(
            'Latitude: ${locations.first.latitude}, Longitude: ${locations.first.longitude}');

        return GeoPoint(locations.first.latitude, locations.first.longitude);
      } else {
        print('No location found for the given address');
        return GeoPoint(0.0, 0.0);
      }
    } catch (e) {
      log('Error: during get lat long from address $e');
      return GeoPoint(0.0, 0.0);
    } 
  }
}
