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

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({
    Key? key,
    required this.date,
    required this.changeDate,
  }) : super(key: key);

  final DateTime date;
  final Function({int? day, int? month, int? year}) changeDate;

  @override
  Widget build(BuildContext context) {
    final dayFirst = date.setDay(to: 1).weekday;
    final dayOffset = dayFirst == 7 ? 0 : dayFirst;
    final days = DateUtils.getDaysInMonth(date.year, date.month);
    final today = DateTime.now().day;
    final isSameMonth = DateUtils.isSameMonth(date, DateTime.now());
    return GridView.count(
      crossAxisCount: 7,
      children: List<Widget>.generate(days + dayOffset, (index) {
        if (dayFirst < 7) {
          if (index < dayFirst) {
            return const SizedBox();
          }
          final day = index - dayFirst;
          return CalendarTile(
            day: day,
            isSelected: day == date.day,
            isToday: isSameMonth && date.day == today,
            changeDate: changeDate,
          );
        }
        final day = index + 1;
        return CalendarTile(
          day: day,
          isSelected: day == date.day,
          isToday: isSameMonth && day == today,
          changeDate: changeDate,
        );
      }),
    );
  }
}

class CalendarTile extends StatelessWidget {
  const CalendarTile({
    Key? key,
    required this.day,
    required this.isSelected,
    required this.changeDate,
    this.isToday = false,
  }) : super(key: key);

  final int day;
  final bool isSelected;
  final Function({int? day, int? month, int? year}) changeDate;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final fontWeight =
        isSelected || isToday ? FontWeight.w900 : FontWeight.w400;
    final fontSize = isSelected || isToday ? 20.0 : 14.0;
    final fontColor = isSelected
        ? onContainerGreen
        : isToday
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
            (day).toString(),
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
