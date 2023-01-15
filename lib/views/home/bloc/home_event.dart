// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeStarted extends HomeEvent {}

class HomeLoadTransaction extends HomeEvent {
  final DateTime date;

  const HomeLoadTransaction({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}

class HomeDeleteTransaction extends HomeEvent {
  final Transaction transaction;

  const HomeDeleteTransaction(this.transaction);
}

class HomeUpdatePage extends HomeEvent {
  final DateTime date;

  const HomeUpdatePage({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}

class HomeAnimationFinish extends HomeEvent {}
