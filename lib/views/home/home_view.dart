import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:montra/models/category.dart';
import 'package:montra/widgets/calendar_dialog/calendar_dialog.dart';
import '../../constants/categories.dart';
import '../../helpers/datetime_helper.dart';
import '../../helpers/duration_helper.dart';
import '../../services/transaction_service.dart';

import '../../constants/colors.dart';
import '../../helpers/box_spacing.dart';
import '../../helpers/number_helper.dart';
import '../transaction/transaction_view.dart';

import 'bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'components/home_date_list.dart';
part 'components/home_fab.dart';
part 'components/home_header.dart';
part 'components/home_summary_card.dart';
part 'components/home_transaction_list.dart';

typedef AnimatePageFunc = void Function({DateTime? from, required DateTime to});
typedef UpdateTransaction = Future<void> Function({
  required HomeLoaded state,
  required HomeBloc bloc,
  int? recordKey,
  double? amount,
  DateTime? date,
  Category? category,
});

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _pageController = PageController(
    viewportFraction: 0.15,
    initialPage: DateUtils.dateOnly(DateTime.now()).day - 1,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void animatePage({DateTime? from, required DateTime to}) {
    final fromDay = from?.day ?? DateTime.now().day;
    final duration = min((fromDay - to.day).abs(), 5) * 150;

    _pageController.animateToPage(
      to.day - 1,
      duration: duration.millisecond,
      curve: Curves.easeInOut,
    );
  }

  Future<void> updateTransaction({
    required HomeLoaded state,
    required HomeBloc bloc,
    int? recordKey,
    double? amount,
    DateTime? date,
    Category? category,
  }) async {
    final newDate = await Navigator.push<DateTime>(
        context,
        MaterialPageRoute(
          builder: (context) => TransactionView(
            recordKey: recordKey,
            amount: amount ?? 0,
            date: date ?? state.date,
            category: category ?? expenses.first,
          ),
        ));
    if (newDate != null) {
      animatePage(from: state.date, to: newDate);
      bloc.add(HomeLoadTransaction(date: newDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionService = context.read<TransactionService>();
    return BlocProvider(
      create: (context) {
        return HomeBloc(transactionService)..add(HomeStarted());
      },
      child: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              return Scaffold(
                  floatingActionButton: HomeFab(
                    updateTransactionFunc: updateTransaction,
                  ),
                  body: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        HomeHeader(
                          animatePageFunc: animatePage,
                        ),
                        16.vSpace,
                        const HomeSummaryCard(),
                        16.vSpace,
                        HomeDateList(
                          controller: _pageController,
                          animatePageFunc: animatePage,
                        ),
                        16.vSpace,
                        HomeTransactionList(
                          updateTransactionFunc: updateTransaction,
                        ),
                      ],
                    ),
                  ));
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
