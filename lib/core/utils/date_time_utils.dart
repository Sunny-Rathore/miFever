import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const String dateTimeFormatPattern = 'dd/MM/yyyy';

extension DateTimeExtension on DateTime {
  /// Return a string representing [date] formatted according to our locale
  String format([
    String pattern = dateTimeFormatPattern,
    String? locale,
  ]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}

String getTimeAgo(DateTime time) {
  Duration difference = DateTime.now().difference(time);
  if (difference.inDays > 365) {
    return '${(difference.inDays / 365).floor()} ${(difference.inDays / 365).floor() > 1 ? 'years' : 'year'} ago';
  } else if (difference.inDays > 30) {
    return '${(difference.inDays / 30).floor()} ${(difference.inDays / 30).floor() > 1 ? 'months' : 'month'} ago';
  } else if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays > 1 ? 'days' : 'day'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours > 1 ? 'hours' : 'hour'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes > 1 ? 'minutes' : 'minute'} ago';
  } else {
    return 'just now';
  }
}

int calculateAge(DateTime birthDate) {
  final now = DateTime.now();
  int age = now.year - birthDate.year;
  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    age--;
  }
  return age;
}

int calculateAgeFromString(String birthDateString) {
  // Split the birthDateString into day, month, and year
  List<String> parts = birthDateString.split('/');

  // Parse the day, month, and year as integers
  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);

  // Create a DateTime object from the parsed values
  DateTime birthDate = DateTime(year, month, day);

  // Call the calculateAge function with the parsed DateTime object
  return calculateAge(birthDate);
}

String convertUtcToLocal(DateTime time) {
  try {
    var dateUtc = time;
    return "${dateUtc.hour.toString().length > 1 ? dateUtc.hour : '0' + dateUtc.hour.toString()}:${dateUtc.minute.toString().length > 1 ? dateUtc.minute : '0' + dateUtc.minute.toString()}";
  } catch (e) {
    return 'Invalid time format';
  }
}

String formatMinutesToHours(int minutes) {
  if (minutes <= 0) {
    return '0:00';
  }

  int hours = minutes ~/ 60;
  int remainingMinutes = minutes % 60;

  String formattedHours = hours.toString();
  String formattedMinutes = remainingMinutes.toString().padLeft(2, '0');

  return '$formattedHours:$formattedMinutes';
}
