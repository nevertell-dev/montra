// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:montra/views/home/home_view.dart';

class HomeTransactionList extends StatelessWidget {
  const HomeTransactionList({
    Key? key,
    required this.updateTransactionFunc,
  }) : super(key: key);

  final UpdateTransaction updateTransactionFunc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                return HomeTransactionCard(
                  id: index,
                  updateTransactionFunc: updateTransactionFunc,
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class HomeTransactionCard extends StatelessWidget {
  const HomeTransactionCard({
    Key? key,
    required this.id,
    required this.updateTransactionFunc,
  }) : super(key: key);

  final int id;
  final UpdateTransaction updateTransactionFunc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          final bloc = context.read<HomeBloc>();
          final transactions = state.transactions[id]!;
          return Slidable(
            startActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  label: 'Delete',
                  foregroundColor: onContainerRed,
                  backgroundColor: containerRed,
                  onPressed: (context) =>
                      {bloc.add(HomeDeleteTransaction(transactions))},
                )
              ],
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => updateTransactionFunc(
                bloc: bloc,
                state: state,
                recordKey: transactions.key,
                amount: transactions.amount,
                date: transactions.date,
                category: transactions.category,
              ),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                          foregroundImage: AssetImage(
                              'img/${transactions.category.img}.png')),
                      16.hSpace,
                      Text(transactions.category.toString()),
                      const Spacer(),
                      Text(transactions.amount.formatted,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: transactions.category is Income
                                ? onContainerGreen
                                : onContainerRed,
                          )),
                    ]),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
