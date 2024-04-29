class AboutMe {
  String thingsYouLike;
  String aboutMyCulture;
  String whatKindPerson;
  String hobbiesAndActivity;
  String favLocation;

  AboutMe({
    required this.thingsYouLike,
    required this.aboutMyCulture,
    required this.whatKindPerson,
    required this.hobbiesAndActivity,
    required this.favLocation,
  });

  // Convert AboutMe object to a Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'thingsYouLike': thingsYouLike,
      'aboutMyCulture': aboutMyCulture,
      'whatKindPerson': whatKindPerson,
      'hobbiesAndActivity': hobbiesAndActivity,
      'favLocation': favLocation,
    };
  }

  // Create an AboutMe object from a Map<String, dynamic>
  factory AboutMe.fromJson(Map<String, dynamic> json) {
    return AboutMe(
      thingsYouLike: json['thingsYouLike'] ?? '',
      aboutMyCulture: json['aboutMyCulture'] ?? '',
      whatKindPerson: json['whatKindPerson'] ?? '',
      hobbiesAndActivity: json['hobbiesAndActivity'] ?? '',
      favLocation: json['favLocation'] ?? '',
    );
  }
}
