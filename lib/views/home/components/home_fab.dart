// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:montra/views/home/home_view.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({
    Key? key,
    required this.updateTransactionFunc,
  }) : super(key: key);

  final UpdateTransaction updateTransactionFunc;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          return FloatingActionButton(
            onPressed: () async => await updateTransactionFunc(
              state: state,
              bloc: bloc,
            ),
            backgroundColor: onContainerGreen,
            child: const Icon(Icons.add),
          );
        }
        return Container();
      },
    );
  }
}
