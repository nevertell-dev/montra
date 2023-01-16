// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show DateUtils, PageController;
import 'package:montra/helpers/datetime_helper.dart';

import 'package:montra/services/transaction_service.dart';

import '../../../models/transaction.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TransactionService transactionService;
  final PageController pageController;

  HomeBloc(this.transactionService, this.pageController)
      : super(HomeInitial()) {
    on<HomeEvent>((event, emit) => _homeEvent(event, emit),
        transformer: sequential());
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

  void _homeEvent(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeStarted) {
      await transactionService.init();
      add(HomeLoadTransaction(date: DateUtils.dateOnly(DateTime.now())));
    } else if (event is HomeLoadTransaction) {
      final date = event.date;
      final daysInMonth = DateUtils.getDaysInMonth(date.year, date.month);

      final dailyRecord = transactionService.readDaily(date.asDayKey);
      final monthlyRecord = transactionService.readMonthly(date.asMonthKey);

      emit(HomeLoaded(
        pageController: pageController,
        date: date,
        daysInMonth: daysInMonth,
        daily: dailyRecord,
        monthly: monthlyRecord,
        transactions: _getTransactions(from: dailyRecord),
      ));
    } else if (event is HomeDeleteTransaction) {
      final date = event.transaction.date;
      await transactionService.deleteTransaction(event.transaction);
      add(HomeLoadTransaction(date: date));
    }

    final state = this.state;
    if (state is HomeLoaded) {
      if (event is HomeUpdatePage) {
        final date = event.date;
        final dailyRecord = transactionService.readDaily(date.asDayKey);
        final monthlyRecord = transactionService.readMonthly(date.asMonthKey);

        emit(state.copyWith(
          date: date,
          daily: dailyRecord,
          monthly: monthlyRecord,
          transactions: _getTransactions(from: dailyRecord),
        ));
      }
    }
  }

  List<Transaction?> _getTransactions({Daily? from}) {
    final transactions = from?.transactions
        .map((e) => transactionService.readTransaction(e))
        .toList();

    return transactions ?? <Transaction?>[];
  }
}
