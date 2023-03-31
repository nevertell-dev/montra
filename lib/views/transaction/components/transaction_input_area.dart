// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:montra/views/transaction/transaction_view.dart';

class TransactionInputArea extends StatelessWidget {
  const TransactionInputArea({Key? key}) : super(key: key);

  TextStyle get _textStyle => const TextStyle(
        height: 1,
        color: justBlack,
        fontSize: 36.0,
        fontWeight: FontWeight.w700,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const InputAreaCategoryIcon(),
              16.vSpace,
              InputAreaAmount(textStyle: _textStyle),
              8.vSpace,
              const Text('for'),
              8.vSpace,
              InputAreaCategory(textStyle: _textStyle),
              8.vSpace,
              InputAreaDate(textStyle: _textStyle),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class InputAreaCategoryIcon extends StatelessWidget {
  const InputAreaCategoryIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoaded) {
          return CircleAvatar(
            radius: 100,
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            foregroundImage: AssetImage('img/3.0x/${state.category.img}.png'),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class InputAreaAmount extends StatefulWidget {
  const InputAreaAmount({
    Key? key,
    required this.textStyle,
  }) : super(key: key);

  final TextStyle textStyle;

  @override
  State<InputAreaAmount> createState() => _InputAreaAmountState();
}

class _InputAreaAmountState extends State<InputAreaAmount> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController()
      ..addListener(() {
        _controller.value = _controller.value.copyWith(
          selection: TextSelection.collapsed(
            offset: _controller.value.text.length,
          ),
        );
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        final bloc = context.read<TransactionBloc>();
        if (state is TransactionLoaded) {
          _controller.text = state.amount.formatted;
          return Focus(
            onFocusChange: (onFocus) {
              if (onFocus && _controller.text == '0') {
                _controller.clear();
              }

              if (!onFocus && _controller.text.isEmpty) {
                _controller.text = '0';
              }
            },
            child: TextField(
              controller: _controller,
              autofocus: true,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration.collapsed(
                hintText: null,
                hintStyle: widget.textStyle,
              ),
              onChanged: (string) {
                final amount = double.tryParse(string) ?? 0;
                bloc.add(TransactionUpdateAmount(amount: amount));
              },
              style: widget.textStyle,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class InputAreaCategory extends StatelessWidget {
  const InputAreaCategory({
    Key? key,
    required this.textStyle,
  }) : super(key: key);

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoaded) {
          return TextButton(
            onPressed: () async {
              showModalBottomSheet(
                backgroundColor: const Color(0xFFFFFFFF),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                context: context,
                builder: (_) {
                  return BlocProvider.value(
                    value: context.read<TransactionBloc>(),
                    child: const TransactionCategoryPicker(),
                  );
                },
              );
            },
            child: Text(state.category.title, style: textStyle),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class InputAreaDate extends StatelessWidget {
  const InputAreaDate({
    Key? key,
    required this.textStyle,
  }) : super(key: key);

  final TextStyle textStyle;

  String _getDateString(DateTime date) {
    final dayNow = DateUtils.dateOnly(DateTime.now());
    final dayNew = DateUtils.dateOnly(date);
    final dayDelta = dayNow.difference(dayNew).inDays;

    switch (dayDelta) {
      case 1:
        return 'Yesterday';
      case 0:
        return 'Today';
      case -1:
        return 'Tomorrow';
      default:
        return DateFormat('dd MMM yy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        final bloc = context.read<TransactionBloc>();
        if (state is TransactionLoaded) {
          return TextButton(
            onPressed: () async {
              final pickedDate = await showDialog(
                  context: context,
                  builder: (context) => CalendarDialog(startDate: state.date));

              if (pickedDate != null) {
                bloc.add(TransactionUpdateDate(date: pickedDate));
              }
            },
            child: Text(_getDateString(state.date), style: textStyle),
          );
        }
        return const SizedBox();
      },
    );
  }
}
