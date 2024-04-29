class ThermometerModel {
  final String roomId;
  final String timestamp;
  final int percentageValue;
  final List? userIds;
  ThermometerModel({
    required this.roomId,
    required this.percentageValue,
    required this.timestamp,
    this.userIds,
  });

  factory ThermometerModel.fromJson(Map<String, dynamic> json) =>
      ThermometerModel(
          roomId: json['roomId'],
          percentageValue: json['percentageValue'],
          userIds: json['userIds'] ?? [],
          timestamp: json['timestamp']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['roomId'] = roomId;
    data['percentageValue'] = percentageValue;
    data['timestamp'] = timestamp;
    if (userIds != null) data['userIds'] = userIds;
    return data;
  }
}
