part of 'new_account_bloc.dart';

abstract class NewAccountEvent extends Equatable {
  const NewAccountEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends NewAccountEvent {}

class EmailChanged extends NewAccountEvent {}

class PasswordChanged extends NewAccountEvent {}

class PasswordActivated extends NewAccountEvent {}

class FormSubmitted extends NewAccountEvent {}
