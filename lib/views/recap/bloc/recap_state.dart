part of 'recap_bloc.dart';

abstract class RecapState extends Equatable {
  const RecapState();
  
  @override
  List<Object> get props => [];
}

class RecapInitial extends RecapState {}
