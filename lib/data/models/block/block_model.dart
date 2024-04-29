class BlockModel {
  final String roomId;
  final String blockTo;
  final String blockBy;
  final String reason;
  final String otherReason;

  BlockModel({
    required this.blockTo,
    required this.roomId,
    required this.blockBy,
    required this.reason,
    required this.otherReason,
  });

  factory BlockModel.fromJson(Map<String, dynamic> json) => BlockModel(
        roomId: json['roomId'],
        blockTo: json['blockTo'],
        blockBy: json['blockBy'],
        reason: json['reason'],
        otherReason: json['otherReason'],
      );

  Map<String, dynamic> toJson() => {
        'blockTo': blockTo,
        'blockBy': blockBy,
        'reason': reason,
        'otherReason': otherReason,
        'roomId': roomId,
      };
}
