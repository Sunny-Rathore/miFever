class TextTriesModel {
  final String userId;
  final String timestamp;
  final String chances;

  TextTriesModel({
    required this.userId,
    required this.timestamp,
    required this.chances,
  });

  factory TextTriesModel.fromJson(Map<String, dynamic> json) => TextTriesModel(
      userId: json['userId'],
      timestamp: json['timestamp'],
      chances: json['chances']);

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'timestamp': timestamp,
        'chances': chances,
      };
}
