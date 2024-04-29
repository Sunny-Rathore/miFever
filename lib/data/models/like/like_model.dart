class LikeModel {
  final String? roomId;
  final List? userIds;
  final List? notSeenUserIds;
  final String? timestamp;
  final String? updateTimestamp;
  final bool? isMatched;
  final bool? isSuperLiked;
  final bool? directMatch;
  final String? requestedTo;
  final String? chatTimeStamp;
  final bool? isDeleted;

  LikeModel(
      {this.roomId,
      this.userIds,
      this.notSeenUserIds,
      this.timestamp,
      this.updateTimestamp,
      this.isMatched,
      this.isSuperLiked,
      this.directMatch,
      this.requestedTo,
      this.chatTimeStamp,
      this.isDeleted});

  factory LikeModel.fromJson(Map<String, dynamic> json) => LikeModel(
      roomId: json['roomId'] ?? '',
      userIds: json['userIds'] ?? [],
      notSeenUserIds: json['notSeenUserIds'] ?? [],
      timestamp: json['timestamp'],
      updateTimestamp: json['updateTimestamp'],
      isMatched: json['isMatched'] ?? false,
      isSuperLiked: json['isSuperLiked'] ?? false,
      directMatch: json['directMatch'] ?? false,
      requestedTo: json['requestedTo'] ?? '',
      chatTimeStamp: json['chatTimeStamp'] ??
          DateTime.now().subtract(Duration(days: 365)).toString(),
      isDeleted: json['isDeleted'] ?? false);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (roomId != null) data['roomId'] = roomId;
    if (userIds != null) data['userIds'] = userIds;
    if (notSeenUserIds != null) data['notSeenUserIds'] = notSeenUserIds;
    if (timestamp != null) data['timestamp'] = timestamp;
    if (updateTimestamp != null) data['updateTimestamp'] = updateTimestamp;
    if (isMatched != null) data['isMatched'] = isMatched;
    if (isSuperLiked != null) data['isSuperLiked'] = isSuperLiked;
    if (directMatch != null) data['directMatch'] = directMatch;
    if (requestedTo != null) data['requestedTo'] = requestedTo;
    if (chatTimeStamp != null) data['chatTimeStamp'] = chatTimeStamp;
    if (isDeleted != null) data['isDeleted'] = isDeleted;
    return data;
  }
}
