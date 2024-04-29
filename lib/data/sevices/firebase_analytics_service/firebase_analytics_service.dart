import 'package:mifever/core/app_export.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class AnalyticsService {
  static Mixpanel? mixpanel;

  static Future<void> initMixpanel() async {
    mixpanel = await Mixpanel.init("a85e8301d4302826bf63f812d3622e0f",
        trackAutomaticEvents: true);
    mixpanel!.identify(PrefUtils.getId());
    mixpanel!.getPeople().set("name", PrefUtils.getUserName());
    mixpanel!.getPeople().set("region", PrefUtils.getCountry());
    mixpanel!.getPeople().set("gender", PrefUtils.getUserGender());
    mixpanel!.getPeople().set("\$email", PrefUtils.getUserEmail());
    // mixpanel!.getPeople().set("\$city", PrefUtils.getCity());

    // mixpanel!.getPeople().set("email_address", 'email@gmail.com');
  }

  // Track with event-name
  static void login() {
    print('login event');
    mixpanel!.track('login', properties: {
      'user_id': PrefUtils.getId(),
      'name': PrefUtils.getUserName()
    });
  }

// Track with event-name
  static void signUp() {
    print('signUp event');
    mixpanel!.track('signUp', properties: {
      'user_id': PrefUtils.getId(),
      'name': PrefUtils.getUserName()
    });
  }

  static void logout() {
    print('logout event');
    mixpanel!.track('logout', properties: {
      'user_id': PrefUtils.getId(),
      'name': PrefUtils.getUserName()
    });
  }

  static void view(String userName) {
    mixpanel!.track('view profile',
        properties: {'view_by': PrefUtils.getUserName(), 'view_to': userName});
  }

  static void like(String userName) {
    mixpanel!.track('like', properties: {
      'liked_by': PrefUtils.getUserName(),
      'liked_to': userName
    });
  }

  static void match(String userName) {
    mixpanel!.track('like', properties: {
      'user_one': PrefUtils.getUserName(),
      'user_two': userName
    });
  }

  static void block(String userName) {
    mixpanel!.track('block',
        properties: {'block_by': PrefUtils.getUserName(), 'user_to': userName});
  }

  static void report(String userName) {
    mixpanel!.track('report', properties: {
      'report_by': PrefUtils.getUserName(),
      'report_to': userName
    });
  }

  static void dislike(String userName) {
    mixpanel!.track('dislike', properties: {
      'dislike_by': PrefUtils.getUserName(),
      'dislike_to': userName
    });
  }

  static void unMatch(String userName) {
    mixpanel!.track('unMatch', properties: {
      'unMatch_by': PrefUtils.getUserName(),
      'unMatch_to': userName
    });
  }

  static void unBlocked(String userName) {
    mixpanel!.track('unBlocked', properties: {
      'unBlocked_by': PrefUtils.getUserName(),
      'unBlocked_to': userName
    });
  }
}
