// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:montra/views/recap/recap_view.dart';

class RecapHeader extends StatelessWidget {
  const RecapHeader({
    Key? key,
    required this.date,
  }) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        Text(
          DateFormat('MMMM y').format(date),
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
