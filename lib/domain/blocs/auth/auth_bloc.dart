import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_test/domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late User user = const User(email: "", name: "", password: "");

  AuthBloc() : super(AuthInitial()) {
    // on<AppStarted>(_onAppStartedToState);
    on<LoggedIn>(_onLoggedInToState);
    on<LoggedOut>(_onLoggedOutToState);
  }

  void _onLoggedInToState(
    LoggedIn event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthLoading());
    user = event.user;
    emit(AuthAuthenticated());
  }

  void _onLoggedOutToState(
    LoggedOut event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthLoading());
    emit(AuthUnatheticated());
  }
}
