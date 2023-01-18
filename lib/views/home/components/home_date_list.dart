// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:montra/views/home/home_view.dart';

class HomeDateList extends StatelessWidget {
  const HomeDateList({
    Key? key,
    required this.animatePageFunc,
  }) : super(key: key);

  final AnimatePageFunc animatePageFunc;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          return SizedBox(
              height: 128.0,
              child: PageView.builder(
                clipBehavior: Clip.none,
                controller: state.pageController,
                onPageChanged: (value) {
                  final day = value + 1;
                  bloc.add(
                    HomeUpdatePage(date: state.date.setDay(to: day)),
                  );
                },
                itemCount: state.daysInMonth,
                itemBuilder: (context, index) => HomeDateTile(
                  day: index + 1,
                  animatePageFunc: animatePageFunc,
                ),
              ));
        }
        return Container();
      },
    );
  }
}

class HomeDateTile extends StatelessWidget {
  const HomeDateTile({
    Key? key,
    required this.day,
    required this.animatePageFunc,
  }) : super(key: key);

  final int day;
  final AnimatePageFunc animatePageFunc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          final date = state.date.setDay(to: day);
          return GestureDetector(
            onTap: () async {
              await animatePageFunc(
                controller: state.pageController,
                from: state.date,
                to: date,
              );
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                HomeDateGraph(day: day),
                HomeDateCard(day: day),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class HomeDateCard extends StatelessWidget {
  const HomeDateCard({
    Key? key,
    required this.day,
  }) : super(key: key);

  final int day;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          final isSelected = state.date.day == day;
          final date = state.date.setDay(to: day);

          final matrix = Matrix4.identity();
          final transform = isSelected ? matrix : matrix.scaled(0.9);
          final fontWeightDay = isSelected ? FontWeight.w900 : FontWeight.w400;
          final fontWeightDate = isSelected ? FontWeight.w900 : FontWeight.w700;
          final fontSize = isSelected ? 20.0 : 14.0;
          final today = date == DateUtils.dateOnly(DateTime.now());
          final fontColor = isSelected
              ? onContainerGreen
              : today
                  ? onContainerYellow
                  : onContainerBlue;

          return Container(
            transform: transform,
            transformAlignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat('E').format(date),
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: fontWeightDay,
                    color: fontColor,
                  ),
                ),
                AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: 200.millisecond,
                  transformAlignment: Alignment.center,
                  height: isSelected ? 8 : 0,
                ),
                Text(
                  DateFormat('dd').format(date),
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeightDate,
                    color: fontColor,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class HomeDateGraph extends StatelessWidget {
  const HomeDateGraph({
    Key? key,
    required this.day,
  }) : super(key: key);

  final int day;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          final date = state.date.setDay(to: day);

          final transactionService = context.read<TransactionService>();

          final daily = transactionService.readDaily(date.asDayKey);
          final monthly = state.monthly;
          final highestExpense = daily?.highestExpense ?? 0;
          final highestIncome = daily?.highestIncome ?? 0;

          double expenseHeightMod = 0;
          if (highestExpense > 0) {
            expenseHeightMod =
                highestExpense / (monthly?.highestExpense ?? highestExpense);
          }

          double incomeHeightMod = 0;
          if (highestIncome > 0) {
            incomeHeightMod =
                highestIncome / (monthly?.highestIncome ?? highestIncome);
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 48.0,
                width: 48.0,
                child: CustomPaint(
                  painter: BalanceGraph(
                    color: containerRed,
                    heightMod: -expenseHeightMod,
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
                width: 48.0,
                child: CustomPaint(
                  painter: BalanceGraph(
                    color: containerGreen,
                    heightMod: incomeHeightMod,
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class BalanceGraph extends CustomPainter {
  BalanceGraph({
    required this.heightMod,
    required this.color,
  });

  final double heightMod;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
        0, heightMod < 0 ? size.height : 0, 48.0, 48.0 * heightMod);
    final style = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    canvas.drawRect(rect, style);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
