// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'category.dart';

part 'transaction.g.dart';

abstract class Record extends HiveObject {
  @HiveField(0)
  final double balance;
  @HiveField(1)
  final double income;
  @HiveField(2)
  final double expense;
  @HiveField(3)
  final double highestIncome;
  @HiveField(4)
  final double highestExpense;
  @HiveField(5)
  final List<int> transactions;

  Record({
    this.balance = 0,
    this.income = 0,
    this.expense = 0,
    this.highestIncome = 0,
    this.highestExpense = 0,
    required this.transactions,
  });
}

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  final double amount;
  @HiveField(1)
  final Category category;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final String note;

  Transaction({
    required this.amount,
    required this.category,
    required this.date,
    required this.note,
  });

  @override
  String toString() => '${category.title} : $amount';
}

@HiveType(typeId: 1)
class Daily extends Record {
  Daily({
    super.balance,
    super.income,
    super.expense,
    super.highestIncome,
    super.highestExpense,
    required super.transactions,
  });
}

@HiveType(typeId: 2)
class Monthly extends Record {
  Monthly({
    super.balance,
    super.income,
    super.expense,
    super.highestIncome,
    super.highestExpense,
    required super.transactions,
  });
}

@HiveType(typeId: 3)
class Yearly extends Record {
  Yearly({
    super.balance,
    super.income,
    super.expense,
    super.highestIncome,
    super.highestExpense,
    required super.transactions,
  });
}
