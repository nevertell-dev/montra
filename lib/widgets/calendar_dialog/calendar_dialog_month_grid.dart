part of 'package:montra/widgets/calendar_dialog/calendar_dialog.dart';

class CalendarMonthGrid extends StatelessWidget {
  const CalendarMonthGrid({
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
      childAspectRatio: 2,
      children: List<Widget>.generate(12, (index) {
        final currentMonth = DateTime.now().month;
        final month = index + 1;
        return CalendarMonthTile(
          monthName: DateFormat.MMM().format(date.setMonth(to: month)),
          month: month,
          isSelected: month == date.month,
          isSameMonth: month == currentMonth,
          changeDate: changeDate,
          changeState: changeState,
        );
      }),
    );
  }
}

class CalendarMonthTile extends StatelessWidget {
  const CalendarMonthTile({
    Key? key,
    required this.monthName,
    required this.month,
    required this.isSelected,
    required this.isSameMonth,
    required this.changeDate,
    required this.changeState,
  }) : super(key: key);

  final String monthName;
  final int month;
  final bool isSelected;
  final bool isSameMonth;
  final Function({int? day, int? month, int? year}) changeDate;
  final Function(CalendarState newState) changeState;

  @override
  Widget build(BuildContext context) {
    final fontSize = isSelected || isSameMonth ? 20.0 : 14.0;
    final fontWeight =
        isSelected || isSameMonth ? FontWeight.w900 : FontWeight.w400;
    final fontColor = isSelected
        ? onContainerGreen
        : isSameMonth
            ? onContainerYellow
            : onContainerBlue;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        changeDate(day: 1, month: month);
        await Future.delayed(100.millisecond);
        changeState(CalendarState.pickDay);
      },
      child: Container(
        height: 48.0,
        width: 48.0,
        color: isSelected ? containerGreen : justWhite,
        child: Center(
          child: Text(
            monthName,
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
