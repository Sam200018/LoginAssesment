import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_test/data/reactive_auth_repository.dart';
import 'package:login_test/domain/validators.dart';
import 'package:realauth/auth.dart';
import 'package:retry/retry.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ReactiveAuthRepository _authRepository;

  LoginBloc({required ReactiveAuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginState.initialState()) {
    on<EmailChanged>(_onEmailChangedToState);
    on<EmailSubmitted>(_onEmailSubmittedToState);
    on<PasswordChanged>(_onPasswordChangedToState);
    on<PasswordActivated>(_onPasswordActivatedToState);
    on<PasswordSubmitted>(_onPasswordSubmittedToState);
  }

  void _onEmailChangedToState(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.update(
        isEmailValid: Validators.isValidadEmail(emailController.text)));
  }

  Future<void> _onEmailSubmittedToState(
      EmailSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginState.emailLoading());

    try {
      const r = RetryOptions(maxDelay: Duration(minutes: 1), maxAttempts: 4);
      final userExist = await r.retry(() async {
        return await _authRepository.userExists(email: emailController.text);
      },
          // retryIf: (e) => e is Exception,
          onRetry: (e) => emit(LoginState.emailLoading()));
      if (userExist) {
        emit(LoginState.emailSuccess());
      } else {
        emit(LoginState.emailFailure());
      }
    } catch (e) {
      emit(LoginState.failureConnection());
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
      const r = RetryOptions(maxDelay: Duration(minutes: 1), maxAttempts: 4);
      await r.retry(
        () async {
          await _authRepository.logIn(
              email: emailController.text, password: passwordController.text);
          emit(LoginState.passwordSuccess());
          emailController.clear();
          passwordController.clear();
        },
        retryIf: (e) => e is! AuthException,
        onRetry: (e) => emit(LoginState.passwordLoading()),
      );
    } on AuthException {
      emit(LoginState.passwordFailure());
    } catch (e) {
      emit(LoginState.failureConnection());
    }
  }
}
