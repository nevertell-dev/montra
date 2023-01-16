part of 'package:montra/widgets/calendar_dialog/calendar_dialog.dart';

class CalendarDay extends StatelessWidget {
  const CalendarDay({super.key});

  final dayName = const ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: GridView.count(
        crossAxisCount: 7,
        children: List<Center>.generate(7, (index) {
          return Center(
              child: Text(dayName[index],
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w900,
                  )));
        }),
      ),
    );
  }
}

class CalendarDayGrid extends StatelessWidget {
  const CalendarDayGrid({
    Key? key,
    required this.date,
    required this.changeDate,
  }) : super(key: key);

  final DateTime date;
  final Function({int? day, int? month, int? year}) changeDate;

  @override
  Widget build(BuildContext context) {
    final firstWeekday = date.setDay(to: 1).weekday;
    final offsetWeekday = firstWeekday == 7 ? 0 : firstWeekday;
    final totalDay = DateUtils.getDaysInMonth(date.year, date.month);
    final today = DateTime.now().day;
    return GridView.count(
      crossAxisCount: 7,
      children: List<Widget>.generate(totalDay + offsetWeekday, (index) {
        int day = index + 1;

        if (firstWeekday < 7) {
          if (index < firstWeekday) {
            return const SizedBox();
          }
          day = day - firstWeekday;
        }

        return CalendarDayTile(
          day: day,
          isSelected: day == date.day,
          isSameDay: day == today,
          changeDate: changeDate,
        );
      }),
    );
  }
}

class CalendarDayTile extends StatelessWidget {
  const CalendarDayTile({
    Key? key,
    required this.day,
    required this.isSelected,
    required this.isSameDay,
    required this.changeDate,
  }) : super(key: key);

  final int day;
  final bool isSelected;
  final bool isSameDay;
  final Function({int? day, int? month, int? year}) changeDate;

  @override
  Widget build(BuildContext context) {
    final fontSize = isSelected || isSameDay ? 20.0 : 14.0;
    final fontWeight =
        isSelected || isSameDay ? FontWeight.w900 : FontWeight.w400;
    final fontColor = isSelected
        ? onContainerGreen
        : isSameDay
            ? onContainerYellow
            : onContainerBlue;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => changeDate(day: day),
      child: Container(
        height: 48.0,
        width: 48.0,
        color: isSelected ? containerGreen : justWhite,
        child: Center(
          child: Text(
            day.toString(),
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
