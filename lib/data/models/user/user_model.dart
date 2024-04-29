import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mifever/data/models/user/about_me_model.dart';
import 'package:mifever/data/models/user/adiition_details.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? name;
  final String? nameAudio;
  final String? gender;
  final String? dob;
  final List<dynamic>? interestList;
  final String? whatDoYouWant;
  final List<dynamic>? wayAlbum;
  final List<dynamic>? lifeAlbum;
  final String? token;
  final bool? isProfileComplete;
  final AboutMe? aboutMe;
  final GeoPoint? location;
  final Timestamp? lasOnline;
  final String? profileImage;
  final List<dynamic>? availableLocation;
  final String? locationText;
  final bool? isApproved;
  final bool? isNotificationOn;
  final String? timestamp;
  final String? planName;
  final int? audioDuration;
  final AdditionalPersonalInfo? additionalPersonalInfo;
  UserModel({
    this.id,
    this.email,
    this.name,
    this.nameAudio,
    this.gender,
    this.dob,
    this.interestList,
    this.whatDoYouWant,
    this.wayAlbum,
    this.lifeAlbum,
    this.isProfileComplete,
    this.token,
    this.aboutMe,
    this.location,
    this.lasOnline,
    this.profileImage,
    this.availableLocation,
    this.locationText,
    this.isApproved,
    this.isNotificationOn,
    this.timestamp,
    this.planName,
    this.additionalPersonalInfo,
    this.audioDuration,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] ?? '',
        email: json['email'] ?? '',
        name: json['name'] ?? '',
        nameAudio: json['nameAudio'] ?? '',
        gender: json['gender'] ?? '',
        dob: json['dob'] ?? '',
        interestList: json['interestList'] ?? [],
        whatDoYouWant: json['whatDoYouWant'] ?? '',
        wayAlbum: json['wayAlbum'] ?? [],
        lifeAlbum: json['lifeAlbum'] ?? [],
        token: json['token'] ?? '',
        isProfileComplete: json['isProfileComplete'] ?? false,
        aboutMe:
            json['aboutMe'] != null ? AboutMe.fromJson(json['aboutMe']) : null,
        location: json['location'] ?? GeoPoint(0.0, 0.0),
        lasOnline: json['lasOnline'] ?? Timestamp(0, 0),
        profileImage: json['profileImage'] ?? '',
        availableLocation: json['availableLocation'] ?? [],
        locationText: json['locationText'] ?? '',
        isApproved: json['isApproved'] ?? true,
        isNotificationOn: json['isNotificationOn'] ?? true,
        timestamp: json['timestamp'] ?? DateTime.now().toUtc().toString(),
        planName: json['planName'] ?? "",
        audioDuration: json['audioDuration'] ?? 3,
        additionalPersonalInfo: json['additionalPersonalInfo'] != null
            ? AdditionalPersonalInfo.fromJson(json['additionalPersonalInfo'])
            : AdditionalPersonalInfo());
  }

  Map<String, dynamic> toJson() {
    // Create a map to store non-null fields
    Map<String, dynamic> jsonMap = {};

    // Add non-null fields to the map
    if (id != null) jsonMap['id'] = id;
    if (email != null) jsonMap['email'] = email;
    if (name != null) jsonMap['name'] = name;
    if (nameAudio != null) jsonMap['nameAudio'] = nameAudio;
    if (gender != null) jsonMap['gender'] = gender;
    if (dob != null) jsonMap['dob'] = dob;
    if (interestList != null) jsonMap['interestList'] = interestList;
    if (whatDoYouWant != null) jsonMap['whatDoYouWant'] = whatDoYouWant;
    if (wayAlbum != null) jsonMap['wayAlbum'] = wayAlbum;
    if (lifeAlbum != null) jsonMap['lifeAlbum'] = lifeAlbum;
    if (token != null) jsonMap['token'] = token;
    if (isProfileComplete != null)
      jsonMap['isProfileComplete'] = isProfileComplete;
    if (aboutMe != null) jsonMap['aboutMe'] = aboutMe?.toJson();
    if (location != null) jsonMap['location'] = location;
    if (lasOnline != null) jsonMap['lasOnline'] = lasOnline;
    if (profileImage != null) jsonMap['profileImage'] = profileImage;
    if (availableLocation != null)
      jsonMap['availableLocation'] = availableLocation;
    if (locationText != null) jsonMap['locationText'] = locationText;
    if (isApproved != null) jsonMap['isApproved'] = isApproved;
    if (isNotificationOn != null)
      jsonMap['isNotificationOn'] = isNotificationOn;
    if (timestamp != null) jsonMap['timestamp'] = timestamp;
    if (planName != null) jsonMap['planName'] = planName;
    if (audioDuration != null) jsonMap['audioDuration'] = audioDuration;

    if (additionalPersonalInfo != null)
      jsonMap['additionalPersonalInfo'] = additionalPersonalInfo!.toJson();

    return jsonMap;
  }
}

// class UserLocation {
//   final String id;
//   final String text;
//   final GeoPoint latLng;
//   UserLocation({required this.id, required this.text, required this.latLng});

//   factory UserLocation.fromJson(Map<String, dynamic> json) =>
//       UserLocation(id: json['id'], text: json['text'], latLng: json['latLng']);

//   Map<String, dynamic> toJson() => {'id': id, 'text': text, 'latLng': latLng};
// }
