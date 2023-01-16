// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recap_bloc.dart';

abstract class RecapEvent extends Equatable {
  const RecapEvent();

  @override
  List<Object> get props => [];
}

class RecapLoadDetail extends RecapEvent {
  const RecapLoadDetail({
    required this.date,
  });

  final DateTime date;

  @override
  List<Object> get props => [date];
}
