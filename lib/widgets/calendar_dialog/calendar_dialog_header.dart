// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:montra/widgets/calendar_dialog/calendar_dialog.dart';

class CalendarDialogHeader extends StatelessWidget {
  const CalendarDialogHeader({
    Key? key,
    required this.date,
    required this.changeState,
  }) : super(key: key);

  final DateTime date;
  final Function(CalendarState newState) changeState;

  TextStyle get _textStyle => const TextStyle(
        height: 1,
        color: onContainerGreen,
        fontSize: 36.0,
        fontWeight: FontWeight.w700,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            changeState(CalendarState.pickMonth);
          },
          style: TextButton.styleFrom(
              foregroundColor: justBlack,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              )),
          child: Text(DateFormat.MMMM().format(date), style: _textStyle),
        ),
        TextButton(
          onPressed: () {
            changeState(CalendarState.pickYear);
          },
          style: TextButton.styleFrom(
              foregroundColor: justBlack,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              )),
          child: Text(date.year.toString(), style: _textStyle),
        ),
      ],
    );
  }
}
