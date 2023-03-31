// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:montra/views/transaction/transaction_view.dart';

class TransactionCategoryPicker extends StatelessWidget {
  const TransactionCategoryPicker({super.key});

  TextStyle get _textStyle => const TextStyle(
        color: justBlack,
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
      );

  TextStyle get _unselectedTextStyle => const TextStyle(
        color: justBlack,
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 700,
        child: DefaultTabController(
            length: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Scaffold(
                backgroundColor: const Color(0xFFFFFFFF),
                appBar: TabBar(
                  overlayColor: MaterialStateColor.resolveWith((states) {
                    return Colors.transparent;
                  }),
                  dividerColor: Colors.transparent,
                  labelColor: onContainerGreen,
                  labelStyle: _textStyle,
                  unselectedLabelColor: onContainerBlue,
                  unselectedLabelStyle: _unselectedTextStyle,
                  indicator: const UnderlineTabIndicator(),
                  tabs: const [
                    Tab(text: 'Expense'),
                    Tab(text: 'Income'),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TabBarView(children: [
                    CategoryList(categories: expenses),
                    CategoryList(categories: incomes),
                  ]),
                ),
              ),
            )));
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final Set<Category> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryTile(
          category: categories.elementAt(index),
        );
      },
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: containerGreen,
      borderRadius: BorderRadius.circular(12.0),
      onTap: (() {
        context
            .read<TransactionBloc>()
            .add(TransactionUpdateCategory(category: category));
        Navigator.pop(context);
      }),
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundImage: AssetImage('img/${category.img}.png')),
              16.hSpace,
              Text(category.title),
            ],
          ),
        ),
      ),
    );
  }
}
