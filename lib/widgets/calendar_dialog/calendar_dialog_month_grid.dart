part of 'package:montra/widgets/calendar_dialog/calendar_dialog.dart';

class CalendarMonthGrid extends StatelessWidget {
  CalendarMonthGrid({
    Key? key,
    required this.date,
    required this.changeDate,
    required this.changeState,
  }) : super(key: key);

  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final DateTime date;
  final Function({int? day, int? month, int? year}) changeDate;
  final Function(CalendarState newState) changeState;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: List<Widget>.generate(months.length, (index) {
        final currentMonth = DateTime.now().month;
        final month = index + 1;
        return CalendarMonthTile(
          month: month,
          title: months[index],
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
    required this.month,
    required this.title,
    required this.isSelected,
    required this.isSameMonth,
    required this.changeDate,
    required this.changeState,
  }) : super(key: key);

  final int month;
  final String title;
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
            title,
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
