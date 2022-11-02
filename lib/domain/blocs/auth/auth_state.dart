part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._(this.user);

  AuthState.unknown() : this._(User(email: "", name: "", password: ""));

  const AuthState.authenticated(User user) : this._(user);

  AuthState.unauthenticated() : this._(User(email: "", name: "", password: ""));

  final User user;

  @override
  List<Object> get props => [user];
}
