// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final PageController pageController;
  final DateTime date;
  final int daysInMonth;
  final Daily? daily;
  final Monthly? monthly;
  final List<Transaction?> transactions;

  const HomeLoaded({
    required this.pageController,
    required this.date,
    required this.daysInMonth,
    required this.daily,
    required this.monthly,
    required this.transactions,
  });

  @override
  List<Object> get props => [
        date,
        daysInMonth,
        transactions,
      ];

  HomeLoaded copyWith({
    PageController? pageController,
    DateTime? date,
    int? daysInMonth,
    Daily? daily,
    Monthly? monthly,
    List<Transaction?>? transactions,
  }) {
    return HomeLoaded(
      pageController: pageController ?? this.pageController,
      date: date ?? this.date,
      daysInMonth: daysInMonth ?? this.daysInMonth,
      daily: daily,
      monthly: monthly,
      transactions: transactions ?? this.transactions,
    );
  }
}
