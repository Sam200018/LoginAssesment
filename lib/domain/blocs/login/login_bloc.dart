import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_test/data/repositories/login/exceptions.dart';
import 'package:login_test/data/repositories/login/login_repository.dart';
import 'package:login_test/domain/blocs/auth/auth_bloc.dart';
import 'package:login_test/domain/validators.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthRepository _authRepository;
  final AuthBloc _authBloc;

  LoginBloc(
      {required AuthRepository authRepository, required AuthBloc authBloc})
      : _authRepository = authRepository,
        _authBloc = authBloc,
        super(LoginState.initialState()) {
    on<EmailChanged>(_onEmailChangedToState);
    on<EmailSubmitted>(_onEmailSubmittedToState);
    on<PasswordChanged>(_onPasswordChangedToState);
    on<PasswordActivated>(_onPasswordActivatedToState);
    on<PasswordSubmitted>(_onPasswordSubmittedToState);
  }

  void _onEmailChangedToState(EmailChanged evet, Emitter<LoginState> emit) {
    emit(state.update(
        isEmailValid: Validators.isValidadEmail(emailController.text)));
  }

  Future<void> _onEmailSubmittedToState(
      EmailSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginState.emailLoading());
    try {
      final userExist = await _authRepository.userExists(emailController.text);

      if (userExist) {
        emit(LoginState.emailSuccess());
      } else {
        emit(LoginState.emailFailure());
      }
    } catch (e) {
      emit(LoginState.failureConecction());
    }
  }

  void _onPasswordChangedToState(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.update(
        isPasswordValid:
            Validators.isValidAmount(passwordController.text.length)));
  }

  void _onPasswordActivatedToState(
    PasswordActivated event,
    Emitter<LoginState> emit,
  ) {
    emit(state.update(isEnablePassword: !state.isEnablePassword));
  }

  // It means a login trigger event
  Future<void> _onPasswordSubmittedToState(
    PasswordSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.passwordLoading());
    try {
      final user = await _authRepository.login(
          emailController.text, passwordController.text);
      log(user.toString());
      _authBloc.add(LoggedIn(user: user));
      emit(LoginState.passwordSucces());
      emailController.clear();
      passwordController.clear();
    } on AuthException {
      emit(LoginState.passwordFailure());
    } catch (e) {
      emit(LoginState.failureConecction());
    }
  }
}
