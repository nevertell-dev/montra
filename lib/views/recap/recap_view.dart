// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:montra/constants/categories.dart';
import 'package:montra/helpers/box_spacing.dart';
import 'package:montra/helpers/number_helper.dart';
import 'package:montra/services/transaction_service.dart';

import '../../constants/colors.dart';
import '../../models/category.dart';
import 'bloc/recap_bloc.dart';

part './components/recap_header.dart';
part './components/recap_category_list.dart';
part './components/recap_balance.dart';

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RecapHeader(date: state.date),
                      32.vSpace,
                      RecapBalance(balance: state.balance),
                      32.vSpace,
                      RecapCategoryList<Income>(),
                      32.vSpace,
                      RecapCategoryList<Expense>(),
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
