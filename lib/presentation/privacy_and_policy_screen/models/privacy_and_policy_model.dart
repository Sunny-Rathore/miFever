/// This class defines the variables used in the [privacy_and_policy_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class SettingsModel {
  final String termsAndConditions;
  final String privacyPolicy;
  final String communityGuidelines;

  SettingsModel(
      {required this.termsAndConditions,
      required this.privacyPolicy,
      required this.communityGuidelines});

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        termsAndConditions: json['termsAndConditions'],
        privacyPolicy: json['privacyPolicy'],
        communityGuidelines: json['communityGuidelines'],
      );

  Map<String, dynamic> toJson() => {
        'termsAndConditions': termsAndConditions,
        'privacyPolicy': privacyPolicy,
      };
}
