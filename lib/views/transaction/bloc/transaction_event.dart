// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionStarted extends TransactionEvent {
  final double amount;
  final DateTime date;
  final Category category;

  const TransactionStarted({
    required this.amount,
    required this.date,
    required this.category,
  });

  @override
  List<Object> get props => [amount, date, category];
}

class TransactionUpdateAmount extends TransactionEvent {
  final double amount;

  const TransactionUpdateAmount({
    required this.amount,
  });

  @override
  List<Object> get props => [amount];
}

class TransactionUpdateDate extends TransactionEvent {
  final DateTime date;

  const TransactionUpdateDate({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}

class TransactionUpdateCategory extends TransactionEvent {
  final Category category;

  const TransactionUpdateCategory({
    required this.category,
  });

  @override
  List<Object> get props => [category];
}

class TransactionCreateRecord extends TransactionEvent {
  final double amount;
  final Category category;
  final DateTime date;
  final String note;

  const TransactionCreateRecord({
    required this.amount,
    required this.category,
    required this.date,
    required this.note,
  });

  @override
  List<Object> get props => [amount, category, date, note];
}

class TransactionUpdateRecord extends TransactionEvent {
  final int key;
  final double amount;
  final Category category;
  final DateTime date;
  final String note;

  const TransactionUpdateRecord({
    required this.key,
    required this.amount,
    required this.category,
    required this.date,
    required this.note,
  });

  @override
  List<Object> get props => [amount, category, date, note];
}

class TransactionFinish extends TransactionEvent {}
