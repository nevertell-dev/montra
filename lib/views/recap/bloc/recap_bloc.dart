import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recap_event.dart';
part 'recap_state.dart';

class RecapBloc extends Bloc<RecapEvent, RecapState> {
  RecapBloc() : super(RecapInitial()) {
    on<RecapEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
