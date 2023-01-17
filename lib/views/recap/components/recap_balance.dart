// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:montra/views/recap/recap_view.dart';

class RecapBalance extends StatelessWidget {
  const RecapBalance({
    Key? key,
    required this.balance,
  }) : super(key: key);

  final double balance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'This month balance',
          textAlign: TextAlign.center,
        ),
        Text(
          balance.formatted,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
