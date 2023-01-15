// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:montra/constants/categories.dart';
import 'package:montra/constants/colors.dart';
import 'package:montra/helpers/box_spacing.dart';
import 'package:montra/helpers/number_helper.dart';
import 'package:montra/models/category.dart';

import '../../services/transaction_service.dart';
import 'bloc/transaction_bloc.dart';

part './components/transaction_category_picker.dart';
part './components/transaction_footer.dart';
part './components/transaction_header.dart';
part './components/transaction_input_area.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({
    Key? key,
    this.recordKey,
    required this.amount,
    required this.date,
    required this.category,
  }) : super(key: key);

  final int? recordKey;
  final double amount;
  final DateTime date;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionBloc(context.read<TransactionService>())
        ..add(TransactionStarted(
          amount: amount,
          date: date,
          category: category,
        )),
      child: SafeArea(
        child: BlocConsumer<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is TransactionRecorded) {
              Navigator.pop<DateTime>(context, state.date);
            }
          },
          builder: (context, state) {
            if (state is TransactionLoaded) {
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TransactionHeader(),
                      const Expanded(child: TransactionInputArea()),
                      TransactionFooter(recordKey: recordKey),
                    ],
                  ),
                ),
              );
            }
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }
}
