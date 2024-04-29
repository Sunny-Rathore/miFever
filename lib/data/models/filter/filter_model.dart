class PreferenceFilter {
  final String country;
  final String city;
  final double distance;
  final double ageRangeStart;
  final double ageRangeEnd;
  final String interestedIn;
  final String locationText;
  final double lat;
  final double lng;
  final double heightStart;
  final double heightEnd;
  final String horoscope;
  final String smokingStatus;
  final String drinkingStatus;
  final String religion;
  final String maritalStatus;
  final String hairColor;
  final String childrenStatus;
  final String musicPreference;

  final bool isHeightFilterApplied;
  PreferenceFilter({
    required this.isHeightFilterApplied,
    required this.country,
    required this.city,
    required this.distance,
    required this.ageRangeStart,
    required this.ageRangeEnd,
    required this.interestedIn,
    required this.locationText,
    required this.lat,
    required this.lng,
    required this.heightStart,
    required this.heightEnd,
    required this.horoscope,
    required this.smokingStatus,
    required this.drinkingStatus,
    required this.religion,
    required this.maritalStatus,
    required this.hairColor,
    required this.childrenStatus,
    required this.musicPreference,
  });

  factory PreferenceFilter.fromJson(Map<String, dynamic> json) =>
      PreferenceFilter(
          isHeightFilterApplied: json['isHeightFilterApplied'],
          country: json['country'],
          city: json['city'],
          distance: json['distance'],
          ageRangeStart: json['ageRangeStart'],
          ageRangeEnd: json['ageRangeEnd'],
          interestedIn: json['interestedIn'],
          locationText: json['locationText'],
          lat: json['lat'],
          lng: json['lng'],
          heightStart: json['heightStart'],
          heightEnd: json['heightEnd'],
          horoscope: json['horoscope'],
          smokingStatus: json['smokingStatus'],
          drinkingStatus: json['drinkingStatus'],
          religion: json['religion'],
          maritalStatus: json['maritalStatus'],
          hairColor: json['hairColor'],
          childrenStatus: json['childrenStatus'],
          musicPreference: json['musicPreference']);
  Map<String, dynamic> toJson() => {
        'isHeightFilterApplied': isHeightFilterApplied,
        'country': country,
        'city': city,
        'distance': distance,
        'ageRangeStart': ageRangeStart,
        'ageRangeEnd': ageRangeEnd,
        'interestedIn': interestedIn,
        'locationText': locationText,
        'lat': lat,
        'lng': lng,
        'heightStart': heightStart,
        'heightEnd': heightEnd,
        'horoscope': horoscope,
        'smokingStatus': smokingStatus,
        'drinkingStatus': drinkingStatus,
        'religion': religion,
        'maritalStatus': maritalStatus,
        'hairColor': hairColor,
        'childrenStatus': childrenStatus,
        'musicPreference': musicPreference
      };
}
