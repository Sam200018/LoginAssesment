part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged({required this.email});
}

class PasswordChanged extends LoginEvent {}

class PasswordActivated extends LoginEvent {}

class EmailSubmitted extends LoginEvent {}

class PasswordSubmitted extends LoginEvent {}
