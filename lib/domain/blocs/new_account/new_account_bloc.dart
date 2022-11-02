import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:login_test/data/reactive_auth_repositoy.dart';
import 'package:login_test/domain/validators.dart';
import 'package:realauth/auth.dart';

part 'new_account_event.dart';
part 'new_account_state.dart';

class NewAccountBloc extends Bloc<NewAccountEvent, NewAccountState> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ReactiveAuthRepository _authRepository;

  NewAccountBloc({
    required ReactiveAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(NewAccountState.initialState()) {
    on<NameChanged>(_onNameChangedToState);
    on<EmailChanged>(_onEmailChangedToState);
    on<PasswordChanged>(_onPasswodChangedToState);
    on<PasswordActivated>(_onPasswordActivatedToState);
    on<FormSubmitted>(_onFormSubmittedToState);
  }

  void _onNameChangedToState(NameChanged event, Emitter<NewAccountState> emit) {
    emit(
        state.update(isNameValid: Validators.isValidName(nameController.text)));
  }

  void _onEmailChangedToState(
      EmailChanged event, Emitter<NewAccountState> emit) {
    emit(state.update(
        isEmailValid: Validators.isValidadEmail(emailController.text)));
  }

  void _onPasswodChangedToState(
    PasswordChanged event,
    Emitter<NewAccountState> emit,
  ) {
    emit(state.update(
        isPasswordValid: Validators.isValidPassword(passwordController.text)));
  }

  void _onPasswordActivatedToState(
      PasswordActivated event, Emitter<NewAccountState> emit) {
    emit(state.update(isEnablePassword: !state.isEnablePassword));
  }

  Future<void> _onFormSubmittedToState(
    FormSubmitted event,
    Emitter<NewAccountState> emit,
  ) async {
    emit(NewAccountState.isLoading());
    try {
      final userAux = User(
          email: emailController.text,
          name: nameController.text,
          password: passwordController.text);

      await _authRepository.createUser(newUser: userAux);

      emit(NewAccountState.isSuccess());
      nameController.clear();
      emailController.clear();
      passwordController.clear();
    } on UserAlreadyExistsException {
      emit(NewAccountState.isFailure());
    } catch (e) {
      emit(NewAccountState.isFailureConnection());
    }
  }
}
