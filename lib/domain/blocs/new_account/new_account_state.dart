part of 'new_account_bloc.dart';

abstract class NewAccountState extends Equatable {
  const NewAccountState();
  
  @override
  List<Object> get props => [];
}

class NewAccountInitial extends NewAccountState {}
