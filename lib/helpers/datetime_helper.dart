import 'package:intl/intl.dart';

extension ChangeDay on DateTime {
  DateTime setDay({required int to}) => DateTime(year, month, to);
}

extension DateKeyFormatting on DateTime {
  int get asDayKey => int.tryParse(DateFormat('ddMMyyyy').format(this)) ?? 0;
  int get asMonthKey => int.tryParse(DateFormat('MMyyyy').format(this)) ?? 0;
  int get asYearKey => int.tryParse(DateFormat('yyyy').format(this)) ?? 0;
}
