part of 'package:montra/widgets/calendar_dialog/calendar_dialog.dart';

class CalendarYearGrid extends StatelessWidget {
  const CalendarYearGrid({
    Key? key,
    required this.date,
    required this.changeDate,
    required this.changeState,
  }) : super(key: key);

  final DateTime date;
  final Function({int? day, int? month, int? year}) changeDate;
  final Function(CalendarState newState) changeState;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List<Widget>.generate(9, (index) {
        final currentYear = DateTime.now().year;
        final year = index + 2021;
        return CalendarYearTile(
          year: year,
          isSelected: year == date.year,
          isSameYear: year == currentYear,
          changeDate: changeDate,
          changeState: changeState,
        );
      }),
    );
  }
}

class CalendarYearTile extends StatelessWidget {
  const CalendarYearTile({
    Key? key,
    required this.year,
    required this.isSelected,
    required this.isSameYear,
    required this.changeDate,
    required this.changeState,
  }) : super(key: key);

  final int year;
  final bool isSelected;
  final bool isSameYear;
  final Function({int? day, int? month, int? year}) changeDate;
  final Function(CalendarState newState) changeState;

  @override
  Widget build(BuildContext context) {
    final fontSize = isSelected || isSameYear ? 20.0 : 14.0;
    final fontWeight =
        isSelected || isSameYear ? FontWeight.w900 : FontWeight.w400;
    final fontColor = isSelected
        ? onContainerGreen
        : isSameYear
            ? onContainerYellow
            : onContainerBlue;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        changeDate(day: 1, year: year);
        await Future.delayed(100.millisecond);
        changeState(CalendarState.pickDay);
      },
      child: Container(
        height: 48.0,
        width: 48.0,
        color: isSelected ? containerGreen : justWhite,
        child: Center(
          child: Text(
            year.toString(),
            style: TextStyle(
              color: fontColor,
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
