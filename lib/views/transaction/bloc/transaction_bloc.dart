// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:montra/models/category.dart';
import 'package:montra/services/transaction_service.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionService transactionService;

  TransactionBloc(this.transactionService) : super(TransactionInitial()) {
    on<TransactionEvent>(
        (event, emit) async => await _transactionEvent(event, emit),
        transformer: sequential());
  }

  Future<void> _transactionEvent(
    TransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    if (event is TransactionStarted) {
      emit(TransactionLoaded(
        amount: event.amount,
        date: event.date,
        category: event.category,
      ));
    } else {
      final state = this.state;
      if (state is TransactionLoaded) {
        if (event is TransactionUpdateAmount) {
          emit(state.copyWith(amount: event.amount));
        } else if (event is TransactionUpdateDate) {
          emit(state.copyWith(date: event.date));
        } else if (event is TransactionUpdateCategory) {
          emit(state.copyWith(category: event.category));
        } else if (event is TransactionCreateRecord) {
          await transactionService.createTransaction(
            amount: event.amount,
            category: event.category,
            date: event.date,
            note: event.note,
          );
          emit(TransactionRecorded(date: event.date));
        } else if (event is TransactionUpdateRecord) {
          await transactionService.updateTransaction(
            key: event.key,
            amount: event.amount,
            category: event.category,
            date: event.date,
            note: event.note,
          );
          emit(TransactionRecorded(date: event.date));
        }
      }
    }
  }
}
