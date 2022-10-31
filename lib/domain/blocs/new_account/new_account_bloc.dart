import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:login_test/data/repositories/login/exceptions.dart';
import 'package:login_test/data/repositories/login/login_repository.dart';
import 'package:login_test/domain/blocs/auth/auth_bloc.dart';
import 'package:login_test/domain/entities/user.dart';
import 'package:login_test/domain/validators.dart';

part 'new_account_event.dart';
part 'new_account_state.dart';

class NewAccountBloc extends Bloc<NewAccountEvent, NewAccountState> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AuthRepository _authRepository;
  final AuthBloc _authBloc;

  NewAccountBloc({
    required AuthRepository authRepository,
    required AuthBloc authBloc,
  })  : _authRepository = authRepository,
        _authBloc = authBloc,
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

      final user = await _authRepository.createUser(userAux);

      _authBloc.add(LoggedIn(user: user));

      emit(NewAccountState.isSuccess());
    } on UserAlreadyExistsException {
      emit(NewAccountState.isFailure());
    } catch (e) {
      emit(NewAccountState.isFailureConnection());
    }
  }
}
