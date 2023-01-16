// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:montra/helpers/datetime_helper.dart';

import '../../../models/category.dart';
import '../../../models/transaction.dart';
import '../../../services/transaction_service.dart';

part 'recap_event.dart';
part 'recap_state.dart';

class RecapBloc extends Bloc<RecapEvent, RecapState> {
  final TransactionService transactionService;

  RecapBloc(
    this.transactionService,
  ) : super(RecapInitial()) {
    on<RecapLoadDetail>((event, emit) {
      final monthly = transactionService.readMonthly(event.date.asMonthKey);
      if (monthly != null) {
        final dailies = transactionService
            .getDailyTransaction(monthly.transactions.toSet());

        var allTransactions = <Transaction?>[];

        for (var daily in dailies) {
          if (daily != null) {
            final transactions =
                transactionService.getTransactions(daily.transactions.toSet());
            allTransactions.addAll(transactions);
          }
        }

        var incomes = _getList<Income>(from: allTransactions);
        var expenses = _getList<Expense>(from: allTransactions);

        emit(RecapLoaded(
          date: event.date,
          incomes: incomes,
          expenses: expenses,
        ));
      } else {
        emit(RecapLoaded(
          date: event.date,
          incomes: const <Transaction?>[],
          expenses: const <Transaction?>[],
        ));
      }
    });
  }

  List<Transaction?> _getList<T extends Category>({
    required List<Transaction?> from,
  }) {
    final transactions = from.where((t) => t != null && t.category is T);

    if (transactions.isNotEmpty) {
      final sorted = transactions.toList()
        ..sort((a, b) => b!.amount.compareTo(a!.amount));
      return sorted;
    }

    return <Transaction>[];
  }
}
