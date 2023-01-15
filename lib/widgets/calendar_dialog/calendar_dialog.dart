// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:montra/constants/colors.dart';
import 'package:montra/helpers/datetime_helper.dart';

part './calendar_dialog_header.dart';
part './calendar_dialog_body.dart';
part './calendar_dialog_footer.dart';

class CalendarDialog extends StatefulWidget {
  const CalendarDialog({
    Key? key,
    this.startDate,
  }) : super(key: key);

  final DateTime? startDate;

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  late DateTime date;

  @override
  void initState() {
    date = widget.startDate ?? DateTime.now();
    super.initState();
  }

  void changeDate({int? day, int? month, int? year}) {
    setState(() {
      date = DateTime(year ?? date.year, month ?? date.month, day ?? date.day);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 200, horizontal: 24),
      alignment: AlignmentDirectional.center,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CalendarDialogHeader(date: date, changeDate: changeDate),
            const CalendarDay(),
            Expanded(
              child: CalendarGrid(date: date, changeDate: changeDate),
            ),
            CalendarFooter(date: date)
          ],
        ),
      ),
    );
  }
}
