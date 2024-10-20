import 'package:intl/intl.dart';

extension DatetimeExtensions on DateTime {
  String get friendlyFormat => DateFormat.yMMMd().format(this);
}
