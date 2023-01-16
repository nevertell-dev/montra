// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recap_bloc.dart';

abstract class RecapState extends Equatable {
  const RecapState();

  @override
  List<Object> get props => [];
}

class RecapInitial extends RecapState {}

class RecapLoaded extends RecapState {
  const RecapLoaded({
    required this.date,
    required this.incomes,
    required this.expenses,
  });

  final DateTime date;
  final List<Transaction?> incomes;
  final List<Transaction?> expenses;

  @override
  List<Object> get props => [date, incomes, expenses];

  RecapLoaded copyWith({
    DateTime? date,
    List<Transaction?>? incomes,
    List<Transaction?>? expenses,
  }) {
    return RecapLoaded(
      date: date ?? this.date,
      incomes: incomes ?? this.incomes,
      expenses: expenses ?? this.expenses,
    );
  }
}
