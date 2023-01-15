// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:montra/views/transaction/transaction_view.dart';

class TransactionHeader extends StatelessWidget {
  const TransactionHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoaded) {
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
                DateFormat('dd MMMM y').format(state.date),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
