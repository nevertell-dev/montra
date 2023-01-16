// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:montra/views/home/home_view.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
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
          final date = state.date;
          final monthlyBalance = state.monthly?.balance ?? 0;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () async {
                  // DateTime? pickedDate = await showDatePicker(
                  //   context: context,
                  //   initialDate: date,
                  //   firstDate: DateTime(2020),
                  //   lastDate: DateTime(2050),
                  // );
                  final pickedDate = await showDialog(
                    context: context,
                    builder: (context) => CalendarDialog(
                      startDate: state.date,
                    ),
                  );
                  if (pickedDate != null) {
                    bloc.add(HomeLoadTransaction(date: pickedDate));
                    animatePageFunc(
                      controller: state.pageController,
                      from: state.date,
                      to: pickedDate,
                    );
                  }
                },
                child: Text(
                  DateFormat('MMMM y').format(date),
                  style: const TextStyle(
                    color: justBlack,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: monthlyBalance > 0 ? containerGreen : containerRed,
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                child: Text(monthlyBalance.formatted,
                    style: TextStyle(
                      color: monthlyBalance > 0
                          ? onContainerGreen
                          : onContainerRed,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w900,
                    )),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
