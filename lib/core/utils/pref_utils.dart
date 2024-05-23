//ignore: unused_import
import 'dart:convert';

import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/filter/filter_model.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  static void clearPreferencesData() async {
    _sharedPreferences!.clear();
    await FirebaseServices.handleLogOut();
  }

  Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  static Future<void> setId(String value) {
    return _sharedPreferences!.setString('id', value);
  }

  static String getId() {
    return _sharedPreferences?.getString('id') ?? '';
  }

  static Future<void> setUserName(String value) {
    return _sharedPreferences!.setString('userName', value);
  }

  static String getUserName() {
    return _sharedPreferences?.getString('userName') ?? '';
  }

  static Future<void> setUserEmail(String value) {
    return _sharedPreferences!.setString('userEmail', value);
  }

  static String getUserEmail() {
    return _sharedPreferences?.getString('userEmail') ?? '';
  }

  static Future<void> setGender(String value) {
    return _sharedPreferences!.setString('gender', value);
  }

  static String getUserGender() {
    return _sharedPreferences?.getString('gender') ?? '';
  }

  static Future<void> setCountry(String value) {
    return _sharedPreferences!.setString('country', value);
  }

  static String getCountry() {
    return _sharedPreferences?.getString('country') ?? '';
  }

  static Future<void> setCity(String value) {
    return _sharedPreferences!.setString('city', value);
  }

  static String getCity() {
    return _sharedPreferences?.getString('city') ?? '';
  }

  static Future<void> saveFilter(PreferenceFilter filter) async {
    await _sharedPreferences?.setString('filter', jsonEncode(filter.toJson()));
  }

  static Future<void> setAvailableLocation(String value) {
    return _sharedPreferences!.setString('availableLocation', value);
  }

  static String getAvailableLocation() {
    return _sharedPreferences?.getString('availableLocation') ?? '';
  }

  static int getOtp() {
    return _sharedPreferences?.getInt('otp') ?? 0;
  }

  static Future<void> saveOtp(int otp) async {
    await _sharedPreferences?.setInt('otp', otp);
  }

  static Future<void> setLang(String value) {
    return _sharedPreferences!.setString('lang', value);
  }

  static String getLang() {
    return _sharedPreferences?.getString('lang') ?? 'en';
  }

  static Future<void> setIsNotificationON(bool value) {
    return _sharedPreferences!.setBool('isNotificationOn', value);
  }

  static bool getIsNotificationON() {
    return _sharedPreferences?.getBool('isNotificationOn') ?? true;
  }

  static Future<void> setIsCurrentLocation(bool value) {
    return _sharedPreferences!.setBool('isCurrentLocation', value);
  }

  static bool getIsCurrentLocation() {
    return _sharedPreferences?.getBool('isCurrentLocation') ?? true;
  }

  static Future<void> setIsSplash(bool value) {
    return _sharedPreferences!.setBool('IsSplash', value);
  }

  static bool getIsSplash() {
    return _sharedPreferences?.getBool('IsSplash') ?? true;
  }

  static Future<PreferenceFilter?> getFilter() async {
    final jsonString = _sharedPreferences?.getString('filter');
    if (jsonString == null) return null;
    final jsonMap = jsonDecode(jsonString);
    return PreferenceFilter.fromJson(jsonMap);
  }

  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'primary';
    }
  }
}
