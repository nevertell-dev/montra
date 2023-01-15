// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:montra/views/transaction/transaction_view.dart';

class TransactionFooter extends StatelessWidget {
  const TransactionFooter({
    Key? key,
    this.recordKey,
  }) : super(key: key);

  final int? recordKey;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TransactionBloc>();
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoaded) {
          return SizedBox(
            height: 48.0,
            width: double.infinity,
            child: TextButton(
              onPressed: () async {
                if (recordKey != null) {
                  bloc.add(TransactionUpdateRecord(
                    key: recordKey!,
                    amount: state.amount,
                    category: state.category,
                    date: state.date,
                    note: '',
                  ));
                } else {
                  bloc.add(TransactionCreateRecord(
                    amount: state.amount,
                    category: state.category,
                    date: state.date,
                    note: '',
                  ));
                }
              },
              style: TextButton.styleFrom(
                  foregroundColor: justWhite,
                  backgroundColor: onContainerGreen,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  )),
              child: Text(
                  recordKey == null ? 'Add Transaction' : 'Update Transaction'),
            ),
          );
        }
        return Container();
      },
    );
  }
}
