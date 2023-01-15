import 'package:intl/intl.dart';

extension NumberFormatting on num {
  String get formatted => NumberFormat('###,##0', 'en_US').format(this);
}
