class ReportModel {
  final String roomId;
  final String reportTo;
  final String reportBy;
  final String reason;

  ReportModel({
    required this.reportTo,
    required this.roomId,
    required this.reportBy,
    required this.reason,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        roomId: json['roomId'],
        reportTo: json['reportTo'],
        reportBy: json['reportBy'],
        reason: json['reason'],
      );

  Map<String, dynamic> toJson() => {
        'reportTo': reportTo,
        'reportBy': reportBy,
        'reason': reason,
        'roomId': roomId,
      };
}
