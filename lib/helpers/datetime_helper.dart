import 'package:intl/intl.dart';

extension DateChangerHelper on DateTime {
  DateTime setDay({required int to}) => DateTime(year, month, to);
  DateTime setMonth({required int to}) => DateTime(year, to, day);
  DateTime setYear({required int to}) => DateTime(to, month, day);
}

extension DateKeyFormatting on DateTime {
  int get asDayKey => int.tryParse(DateFormat('ddMMyyyy').format(this)) ?? 0;
  int get asMonthKey => int.tryParse(DateFormat('MMyyyy').format(this)) ?? 0;
  int get asYearKey => int.tryParse(DateFormat('yyyy').format(this)) ?? 0;
}
