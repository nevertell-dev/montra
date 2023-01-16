part of 'package:montra/widgets/calendar_dialog/calendar_dialog.dart';

class CalendarDialogFooter extends StatelessWidget {
  const CalendarDialogFooter({
    Key? key,
    required this.date,
  }) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      width: double.infinity,
      child: TextButton(
        onPressed: () async {
          Navigator.pop<DateTime>(context, date);
        },
        style: TextButton.styleFrom(
            foregroundColor: justWhite,
            backgroundColor: onContainerGreen,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            )),
        child: const Text('Change Date'),
      ),
    );
  }
}
