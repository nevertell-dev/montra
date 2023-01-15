// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final double amount;
  final DateTime date;
  final Category category;

  const TransactionLoaded({
    required this.amount,
    required this.date,
    required this.category,
  });

  @override
  List<Object> get props => [amount, date, category];

  TransactionLoaded copyWith({
    double? amount,
    DateTime? date,
    Category? category,
  }) {
    return TransactionLoaded(
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }
}

class TransactionRecorded extends TransactionState {
  final DateTime date;

  const TransactionRecorded({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}
