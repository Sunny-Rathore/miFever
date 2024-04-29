class NotificationModel {
  final String type;
  final String notificationTo;
  final String notificationBy;
  final String createdAt;
  final String? viewTime;

  NotificationModel({
    required this.type,
    required this.notificationTo,
    required this.notificationBy,
    required this.createdAt,
    this.viewTime,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        type: json['type'],
        notificationTo: json['notificationTo'],
        notificationBy: json['notificationBy'],
        createdAt: json['createdAt'],
        viewTime: json['viewTime'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'notificationTo': notificationTo,
        'notificationBy': notificationBy,
        'createdAt': createdAt,
        'viewTime': viewTime ?? '',
      };
}

enum NotificationType {
  Like,
  View,
  Chat,
  DisLike,
  Match,
}
