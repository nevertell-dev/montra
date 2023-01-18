// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'package:montra/models/category.dart';
import 'package:montra/views/recap/recap_view.dart';
import 'package:montra/widgets/calendar_dialog/calendar_dialog.dart';

import '../../constants/categories.dart';
import '../../constants/colors.dart';
import '../../helpers/box_spacing.dart';
import '../../helpers/datetime_helper.dart';
import '../../helpers/duration_helper.dart';
import '../../helpers/number_helper.dart';
import '../../services/transaction_service.dart';
import '../transaction/transaction_view.dart';
import 'bloc/home_bloc.dart';

part 'components/home_date_list.dart';
part 'components/home_fab.dart';
part 'components/home_header.dart';
part 'components/home_summary_card.dart';
part 'components/home_transaction_list.dart';

typedef UpdateTransaction = Future<void> Function({
  required HomeLoaded state,
  required HomeBloc bloc,
  int? recordKey,
  double? amount,
  DateTime? date,
  Category? category,
});

typedef AnimatePageFunc = Future<void> Function({
  required PageController controller,
  DateTime? from,
  required DateTime to,
});

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final PageController _pageController;
  late final TransactionService _transactionService;

  @override
  void initState() {
    _pageController = PageController(
      viewportFraction: 0.15,
      initialPage: DateUtils.dateOnly(DateTime.now()).day - 1,
    );
    _transactionService = context.read<TransactionService>();
    super.initState();
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
      await animatePage(
        controller: state.pageController,
        from: state.date,
        to: newDate,
      );

      bloc.add(HomeLoadTransaction(date: newDate));
    }
  }

  Future<void> animatePage({
    required PageController controller,
    DateTime? from,
    required DateTime to,
  }) async {
    final fromDay = from?.day ?? DateTime.now().day;
    final duration = min((fromDay - to.day).abs(), 5) * 150;

    await controller.animateToPage(
      to.day - 1,
      duration: duration.millisecond,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeBloc(
          _transactionService,
          _pageController,
        )..add(HomeStarted());
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
                        HomeHeader(animatePageFunc: animatePage),
                        16.vSpace,
                        const HomeSummaryCard(),
                        16.vSpace,
                        HomeDateList(animatePageFunc: animatePage),
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
