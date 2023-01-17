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
    required this.incomeMap,
    required this.expenseMap,
    required this.incomeTotal,
    required this.expenseTotal,
    required this.balance,
  });

  final DateTime date;
  final List<Transaction?> incomes;
  final List<Transaction?> expenses;
  final Map<String, double> incomeMap;
  final Map<String, double> expenseMap;
  final double incomeTotal;
  final double expenseTotal;
  final double balance;

  @override
  List<Object> get props => [date, incomes, expenses, incomeMap, expenseMap];

  RecapLoaded copyWith({
    DateTime? date,
    List<Transaction?>? incomes,
    List<Transaction?>? expenses,
    Map<String, double>? incomeMap,
    Map<String, double>? expenseMap,
    double? incomeTotal,
    double? expenseTotal,
    double? balance,
  }) {
    return RecapLoaded(
      date: date ?? this.date,
      incomes: incomes ?? this.incomes,
      expenses: expenses ?? this.expenses,
      incomeMap: incomeMap ?? this.incomeMap,
      expenseMap: expenseMap ?? this.expenseMap,
      incomeTotal: incomeTotal ?? this.incomeTotal,
      expenseTotal: expenseTotal ?? this.expenseTotal,
      balance: balance ?? this.balance,
    );
  }
}
