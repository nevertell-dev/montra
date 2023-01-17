part of 'package:montra/views/recap/recap_view.dart';

class RecapCategoryList<T extends Category> extends StatelessWidget {
  RecapCategoryList({super.key});

  final isIncome = T == Income;

  TextStyle get _textStyle => const TextStyle(
        height: 1,
        color: justBlack,
        fontSize: 20.0,
        fontWeight: FontWeight.w900,
      );

  List<Widget> _generateList(Map<String, double> categoryMap) {
    if (categoryMap.isEmpty) {
      return const [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('No record for any categories this month'),
        ),
      ];
    }

    return List<Widget>.generate(categoryMap.length, (index) {
      final category = isIncome ? incomes : expenses;
      final title = categoryMap.keys.elementAt(index);
      final img = category.firstWhere((element) => element.title == title).img;
      final amount = categoryMap.values.elementAt(index).formatted;
      return RecapCategoryTile(img: img, title: title, amount: amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecapBloc, RecapState>(
      builder: (context, state) {
        if (state is RecapLoaded) {
          return Container(
            decoration: BoxDecoration(
              color: isIncome ? containerGreen : containerRed,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isIncome ? 'Incomes' : 'Expenses',
                        style: _textStyle,
                      ),
                      Text(
                        (isIncome ? state.incomeTotal : state.expenseTotal)
                            .formatted,
                        textAlign: TextAlign.center,
                        style: _textStyle.copyWith(
                            color:
                                isIncome ? onContainerGreen : onContainerRed),
                      ),
                    ],
                  ),
                ),
                ..._generateList(isIncome ? state.incomeMap : state.expenseMap),
                8.vSpace,
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class RecapCategoryTile extends StatelessWidget {
  const RecapCategoryTile({
    Key? key,
    required this.title,
    required this.img,
    required this.amount,
  }) : super(key: key);

  final String title;
  final String img;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        16.hSpace,
        CircleAvatar(
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            foregroundImage: AssetImage('img/$img.png')),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Text(
                  amount,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
