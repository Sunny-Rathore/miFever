import 'package:cloud_firestore/cloud_firestore.dart';

class TravelPlanModel {
  final String? docId;
  final String? userId;
  final String? planName;
  final String? startDate;
  final String? endDate;
  final String? location;
  final GeoPoint? latLng;
  final bool? isActive;

  TravelPlanModel({
    this.docId,
    this.userId,
    this.planName,
    this.startDate,
    this.endDate,
    this.location,
    this.latLng,
    this.isActive,
  });

  factory TravelPlanModel.fromJson(Map<String, dynamic> json) =>
      TravelPlanModel(
        docId: json['docId'] ?? '',
        userId: json['userId'] ?? '',
        planName: json['planName'] ?? '',
        startDate: json['startDate'] ?? '',
        endDate: json['endDate'] ?? '',
        location: json['location'] ?? '',
        latLng: json['latLng'] ?? '',
        isActive: json['isActive'] ?? true,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (docId != null) json['docId'] = docId;
    if (userId != null) json['userId'] = userId;
    if (planName != null) json['planName'] = planName;
    if (startDate != null) json['startDate'] = startDate;
    if (endDate != null) json['endDate'] = endDate;
    if (location != null) json['location'] = location;
    if (latLng != null) json['latLng'] = latLng;
    if (isActive != null) json['isActive'] = isActive;

    return json;
  }
}
