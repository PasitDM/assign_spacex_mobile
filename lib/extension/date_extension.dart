import 'package:intl/intl.dart';

enum DateFormatPattern {
  dayMonthYear("dd MMM yyyy"),
  dayMonthYearHHmm("dd MMM yyyy, HH:mm");

  final String value;

  const DateFormatPattern(this.value);
}

extension FormatDateExtension on DateTime {
  String formatDateTime(DateFormatPattern pattern) {
    return DateFormat(pattern.value).format(this);
  }
}
