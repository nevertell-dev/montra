part of 'package:montra/widgets/calendar_dialog/calendar_dialog.dart';

class CalendarDialogHeader extends StatelessWidget {
  CalendarDialogHeader({
    Key? key,
    required this.date,
    required this.changeDate,
  }) : super(key: key);

  final DateTime date;
  final Function({int? day, int? month, int? year}) changeDate;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'Mei',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<int>(
          alignment: AlignmentDirectional.centerEnd,
          value: date.month,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 24.0,
            fontWeight: FontWeight.w500,
          ),
          iconEnabledColor: const Color(0x00000000),
          underline: const SizedBox(),
          items: List<DropdownMenuItem<int>>.generate(
            12,
            (index) => DropdownMenuItem<int>(
              value: index + 1,
              child: Text(months[index]),
            ),
          ),
          onChanged: (value) => changeDate(month: value),
        ),
        DropdownButton<int>(
          alignment: AlignmentDirectional.centerEnd,
          value: date.year,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
          iconEnabledColor: const Color(0x00000000),
          underline: const SizedBox(),
          items: List<DropdownMenuItem<int>>.generate(
            10,
            (index) => DropdownMenuItem<int>(
              value: index + 2022,
              child: Text((index + 2022).toString()),
            ),
          ),
          onChanged: (value) => changeDate(year: value),
        ),
      ],
    );
  }
}
