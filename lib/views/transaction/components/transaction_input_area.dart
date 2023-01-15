// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:montra/views/transaction/transaction_view.dart';

class TransactionInputArea extends StatefulWidget {
  const TransactionInputArea({Key? key}) : super(key: key);

  @override
  State<TransactionInputArea> createState() => _TransactionInputAreaState();
}

class _TransactionInputAreaState extends State<TransactionInputArea> {
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

  TextStyle get _textStyle => const TextStyle(
        height: 1,
        color: justBlack,
        fontSize: 36.0,
        fontWeight: FontWeight.w700,
      );

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
    final bloc = context.read<TransactionBloc>();
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoaded) {
          _controller.text = state.amount.formatted;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 100,
                  backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                  foregroundImage:
                      AssetImage('img/2.0x/${state.category.img}.png')),
              16.vSpace,
              Focus(
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration.collapsed(
                    hintText: null,
                    hintStyle: _textStyle,
                  ),
                  onChanged: (string) {
                    final amount = double.tryParse(string) ?? 0;
                    bloc.add(TransactionUpdateAmount(amount: amount));
                  },
                  style: _textStyle,
                ),
              ),
              8.vSpace,
              const Text('for'),
              TextButton(
                onPressed: () async {
                  showModalBottomSheet(
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
                child: Text(
                  state.category.title,
                  style: _textStyle,
                ),
              ),
              TextButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: state.date,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2050),
                  );
                  if (pickedDate != null) {
                    bloc.add(TransactionUpdateDate(date: pickedDate));
                  }
                },
                child: Text(_getDateString(state.date), style: _textStyle),
              ),
              32.vSpace,
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
