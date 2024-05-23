class HelpAndSupportModel {
  final String userId;
  final String email;
  final String status;
  final String reason;
  HelpAndSupportModel(
      {required this.userId,
      required this.email,
      required this.status,
      required this.reason});

  factory HelpAndSupportModel.fromJson(Map<String, dynamic> json) =>
      HelpAndSupportModel(
          userId: json['userId'],
          email: json['email'],
          status: json['status'],
          reason: json['reason']);

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'email': email,
        'status': status,
        'reason': reason,
      };
}
