class AdditionalPersonalInfo {
  String? height;
  String? horoscope;
  String? smokingStatus;
  String? drinkingStatus;
  String? religion;
  String? maritalStatus;
  String? children;
  String? naturalHairColor;
  String? musicPreference;

  AdditionalPersonalInfo({
    this.height,
    this.horoscope,
    this.smokingStatus,
    this.drinkingStatus,
    this.religion,
    this.maritalStatus,
    this.children,
    this.naturalHairColor,
    this.musicPreference,
  });

  factory AdditionalPersonalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalPersonalInfo(
      height: json['height'],
      horoscope: json['horoscope'],
      smokingStatus: json['smokingStatus'],
      drinkingStatus: json['drinkingStatus'],
      religion: json['religion'],
      maritalStatus: json['maritalStatus'],
      children: json['children'],
      naturalHairColor: json['naturalHairColor'],
      musicPreference: json['musicPreference'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {};

    if (height != null) jsonMap['height'] = height;
    if (horoscope != null) jsonMap['horoscope'] = horoscope;
    if (smokingStatus != null) jsonMap['smokingStatus'] = smokingStatus;
    if (drinkingStatus != null) jsonMap['drinkingStatus'] = drinkingStatus;
    if (religion != null) jsonMap['religion'] = religion;
    if (maritalStatus != null) jsonMap['maritalStatus'] = maritalStatus;
    if (children != null) jsonMap['children'] = children;
    if (naturalHairColor != null)
      jsonMap['naturalHairColor'] = naturalHairColor;
    if (musicPreference != null) jsonMap['musicPreference'] = musicPreference;

    return jsonMap;
  }
}
