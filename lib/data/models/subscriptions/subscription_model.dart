import 'package:mifever/presentation/subscription_plans_page/models/subscription_plans_model.dart';

class SubscriptionModel {
  final String userId;
  final PlansModel plan;
  final String timestamp;
  final String expireTimestamp;

  SubscriptionModel({
    required this.userId,
    required this.plan,
    required this.timestamp,
    required this.expireTimestamp,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
          userId: json['userId'],
          plan: PlansModel.fromJson(json['plan']),
          timestamp: json['timestamp'],
          expireTimestamp: json['expireTimestamp']);

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'plan': plan.toJson(),
        'timestamp': timestamp,
        'expireTimestamp': expireTimestamp,
      };
}
