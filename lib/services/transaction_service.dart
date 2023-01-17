import 'package:hive/hive.dart';
import '../helpers/datetime_helper.dart';

import '../models/category.dart';
import '../models/transaction.dart';

typedef Report = Map<String, double>;

class TransactionService {
  final initialized = false;
  late Box<Transaction> _transactions;
  late Box<Daily> _daily;
  late Box<Monthly> _monthly;
  late Box<Yearly> _yearly;

  Future<void> init() async {
    if (!initialized) {
      Hive
        ..registerAdapter(TransactionAdapter())
        ..registerAdapter(DailyAdapter())
        ..registerAdapter(MonthlyAdapter())
        ..registerAdapter(YearlyAdapter())
        ..registerAdapter(IncomeAdapter())
        ..registerAdapter(ExpenseAdapter());
      await Hive.openBox<Transaction>('Transaction');
      await Hive.openBox<Daily>('DailyTransaction');
      await Hive.openBox<Monthly>('MonthlyTransaction');
      await Hive.openBox<Yearly>('YearlyTransaction');
      initialized == true;
    }
    _transactions = Hive.box('Transaction');
    _daily = Hive.box('DailyTransaction');
    _monthly = Hive.box('MonthlyTransaction');
    _yearly = Hive.box('YearlyTransaction');
  }

  Future<void> createTransaction({
    required double amount,
    required Category category,
    required DateTime date,
    required String note,
  }) async {
    final transaction = Transaction(
      amount: amount,
      category: category,
      date: date,
      note: note,
    );

    final key = await _transactions.add(transaction);
    await updateRecords(key: key, date: date);
  }

  Future<void> updateTransaction({
    required int key,
    required double amount,
    required Category category,
    required DateTime date,
    required String note,
  }) async {
    final transaction = Transaction(
      amount: amount,
      category: category,
      date: date,
      note: note,
    );

    final origin = readTransaction(key);
    deleteTransaction(origin!);

    await _transactions.put(key, transaction);
    await updateRecords(key: key, date: date);
  }

  Transaction? readTransaction(int key) {
    return _transactions.get(key);
  }

  Daily? readDaily(int dayKey) {
    return _daily.get(dayKey);
  }

  Monthly? readMonthly(int monthKey) {
    return _monthly.get(monthKey);
  }

  Yearly? readYearly(int yearKey) {
    return _yearly.get(yearKey);
  }

  Future<void> deleteTransaction(Transaction transaction) async {
    final date = transaction.date;
    final key = transaction.key;
    final daily = _daily.get(date.asDayKey);
    daily?.transactions.remove(key);
    await transaction.delete();
    await updateRecords(date: date);
  }

  Future<void> updateRecords({int? key, required DateTime date}) async {
    final daily = _daily.get(date.asDayKey);
    final transactions = <int>{
      if (daily != null) ...daily.transactions,
      if (key != null) key,
    };
    final dailyReport = _updateReport<Daily>(transactions);
    await _daily.put(
      date.asDayKey,
      Daily(
        income: dailyReport['income']!,
        expense: dailyReport['expense']!,
        balance: dailyReport['balance']!,
        highestIncome: dailyReport['highestIncome']!,
        highestExpense: dailyReport['highestExpense']!,
        transactions: transactions.toList(),
      ),
    );

    final monthly = _monthly.get(date.asMonthKey);
    final dailyTransactions = <int>{
      if (monthly != null) ...monthly.transactions,
      date.asDayKey,
    };
    final monthlyReport = _updateReport<Monthly>(dailyTransactions);
    await _monthly.put(
      date.asMonthKey,
      Monthly(
        income: monthlyReport['income']!,
        expense: monthlyReport['expense']!,
        balance: monthlyReport['balance']!,
        highestIncome: monthlyReport['highestIncome']!,
        highestExpense: monthlyReport['highestExpense']!,
        transactions: dailyTransactions.toList(),
      ),
    );

    final yearly = _yearly.get(date.asYearKey);
    final monthlyTransactions = <int>{
      if (yearly != null) ...yearly.transactions,
      date.asMonthKey,
    };
    final yearlyReport = _updateReport<Yearly>(monthlyTransactions);
    await _yearly.put(
      date.asYearKey,
      Yearly(
        income: yearlyReport['income']!,
        expense: yearlyReport['expense']!,
        balance: yearlyReport['balance']!,
        highestIncome: dailyReport['highestIncome']!,
        highestExpense: monthlyReport['highestExpense']!,
        transactions: monthlyTransactions.toList(),
      ),
    );
  }

  Iterable<Transaction?> getTransactions(Set<int> keys) {
    return keys
        .map((key) => readTransaction(key))
        .where((element) => element != null);
  }

  Iterable<Daily?> getDailyTransaction(Set<int> keys) {
    return keys
        .map((key) => readDaily(key))
        .where((element) => element != null);
  }

  Iterable<Monthly?> getMonthlyTransaction(Set<int> keys) {
    return keys
        .map((key) => readMonthly(key))
        .where((element) => element != null);
  }

  Report _updateReport<T extends Record>(Set<int> keys) {
    final allTransactions = <Transaction?>[];

    // query to unpack all transaction and add to var allTransactions
    if (T == Daily) {
      allTransactions.addAll(getTransactions(keys));
    } else if (T == Monthly) {
      final dailyTransactions = getDailyTransaction(keys);

      for (final daily in dailyTransactions) {
        final transactions =
            getTransactions(daily?.transactions.toSet() ?? <int>{});
        allTransactions.addAll(transactions);
      }
    } else if (T == Yearly) {
      final monthlyTransactions = getMonthlyTransaction(keys);

      for (final monthly in monthlyTransactions) {
        final dailyTransactions =
            getDailyTransaction(monthly?.transactions.toSet() ?? <int>{});

        for (final daily in dailyTransactions) {
          final transactions =
              getTransactions(daily?.transactions.toSet() ?? <int>{});
          allTransactions.addAll(transactions);
        }
      }
    }

    final income = _getReport<Income>(on: allTransactions);
    final expense = _getReport<Expense>(on: allTransactions);

    return <String, double>{
      'income': income.first,
      'expense': expense.first,
      'balance': income.first - expense.first,
      'highestIncome': income.last,
      'highestExpense': expense.last,
    };
  }

  /// return <list>[total T, highest T]
  List<double> _getReport<T extends Category>(
      {required List<Transaction?> on}) {
    final amounts = on
        .where((t) => t != null && t.category is T)
        .map((t) => t?.amount ?? 0);

    if (amounts.isNotEmpty) {
      final total = amounts.reduce((value, element) => value + element);
      final highest = amounts.toList()..sort((a, b) => b.compareTo(a));
      return <double>[total, highest.first];
    }

    return <double>[0.0, 0.0];
  }
}
