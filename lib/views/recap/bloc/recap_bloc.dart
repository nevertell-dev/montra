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

        final incomes = _getList<Income>(from: allTransactions);
        final expenses = _getList<Expense>(from: allTransactions);

        final incomeMap = _getCategoryMap(incomes);
        final expenseMap = _getCategoryMap(expenses);

        final incomeTotal = _getTotal(incomes);
        final expenseTotal = _getTotal(expenses);

        emit(RecapLoaded(
          date: event.date,
          incomes: incomes,
          expenses: expenses,
          incomeMap: incomeMap,
          expenseMap: expenseMap,
          incomeTotal: incomeTotal,
          expenseTotal: expenseTotal,
          balance: incomeTotal - expenseTotal,
        ));
      } else {
        emit(RecapLoaded(
          date: event.date,
          incomes: const <Transaction?>[],
          expenses: const <Transaction?>[],
          incomeMap: const <String, double>{},
          expenseMap: const <String, double>{},
          incomeTotal: 0,
          expenseTotal: 0,
          balance: 0,
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

  Map<String, double> _getCategoryMap(List<Transaction?> transactions) {
    final mappedTransactions = <String, double>{};
    for (var transaction in transactions) {
      if (transaction != null) {
        var amount = transaction.amount;
        var title = transaction.category.title;

        amount += mappedTransactions[title] ?? 0;

        mappedTransactions[transaction.category.title] = amount;
      }
    }
    return mappedTransactions;
  }

  double _getTotal(List<Transaction?> transactions) {
    if (transactions.isEmpty) {
      return 0;
    }

    return transactions
        .map((e) => e?.amount ?? 0)
        .reduce((value, element) => value + element);
  }
}
