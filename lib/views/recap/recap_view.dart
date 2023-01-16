// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra/services/transaction_service.dart';

import 'bloc/recap_bloc.dart';

class RecapView extends StatelessWidget {
  const RecapView({
    Key? key,
    required this.date,
  }) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecapBloc(context.read<TransactionService>())
        ..add(RecapLoadDetail(date: date)),
      child: SafeArea(
        child: BlocBuilder<RecapBloc, RecapState>(
          builder: (context, state) {
            if (state is RecapLoaded) {
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Total Income'),
                      const Text('Income rank in this month'),
                      Text(state.incomes.toString()),
                      const Text('Total Expense'),
                      const Text('Expense rank in this month'),
                      Text(state.expenses.toString()),
                    ],
                  ),
                ),
              );
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
