part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isEmailValid,
      isPasswordValid,
      isEnablePassword,
      isEmailSubmitting,
      isPasswordSubmitting,
      isEmailSuccess,
      isEmailFailure,
      isFailure,
      isSuccess,
      isFailureConnection;

  const LoginState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isEnablePassword,
    required this.isEmailSubmitting,
    required this.isPasswordSubmitting,
    required this.isEmailSuccess,
    required this.isEmailFailure,
    required this.isSuccess,
    required this.isFailure,
    required this.isFailureConnection,
  });

  @override
  List<Object> get props => [
        isEmailValid,
        isPasswordValid,
        isEnablePassword,
        isEmailSubmitting,
        isPasswordSubmitting,
        isEmailSuccess,
        isEmailFailure,
        isFailure,
        isSuccess,
        isFailureConnection
      ];

  bool get emailInputValid => isEmailValid;

  factory LoginState.initialState() {
    return const LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isEnablePassword: false,
      isEmailFailure: false,
      isEmailSubmitting: false,
      isEmailSuccess: false,
      isPasswordSubmitting: false,
      isSuccess: false,
      isFailureConnection: false,
      isFailure: false,
    );
  }

  factory LoginState.emailLoading() {
    return const LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isEnablePassword: false,
        isEmailFailure: false,
        isEmailSubmitting: true,
        isEmailSuccess: false,
        isPasswordSubmitting: false,
        isSuccess: false,
        isFailureConnection: false,
        isFailure: false);
  }

  factory LoginState.passwordLoading() {
    return const LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isEnablePassword: false,
        isEmailFailure: false,
        isEmailSubmitting: false,
        isEmailSuccess: false,
        isPasswordSubmitting: true,
        isSuccess: false,
        isFailureConnection: false,
        isFailure: false);
  }

  factory LoginState.emailFailure() {
    return const LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isEnablePassword: false,
        isEmailFailure: true,
        isEmailSubmitting: false,
        isEmailSuccess: false,
        isPasswordSubmitting: false,
        isSuccess: false,
        isFailureConnection: false,
        isFailure: false);
  }

  factory LoginState.passwordFailure() {
    return const LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isEnablePassword: false,
        isEmailFailure: false,
        isEmailSubmitting: false,
        isEmailSuccess: false,
        isPasswordSubmitting: false,
        isSuccess: false,
        isFailureConnection: false,
        isFailure: true);
  }

  factory LoginState.emailSuccess() {
    return const LoginState(
        isEmailValid: true,
        isEmailFailure: false,
        isEmailSubmitting: false,
        isEmailSuccess: true,
        isPasswordValid: true,
        isEnablePassword: false,
        isPasswordSubmitting: false,
        isSuccess: false,
        isFailureConnection: false,
        isFailure: false);
  }

  factory LoginState.passwordSuccess() {
    return const LoginState(
        isEmailValid: true,
        isEmailFailure: false,
        isEmailSubmitting: false,
        isEmailSuccess: false,
        isPasswordValid: true,
        isEnablePassword: false,
        isPasswordSubmitting: false,
        isSuccess: true,
        isFailureConnection: false,
        isFailure: false);
  }

  factory LoginState.failureConecction() {
    return const LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isEnablePassword: false,
        isEmailFailure: false,
        isEmailSubmitting: false,
        isEmailSuccess: false,
        isPasswordSubmitting: false,
        isSuccess: false,
        isFailureConnection: true,
        isFailure: false);
  }

  LoginState copyWith(
      {bool? isEmailValid,
      bool? isPasswordValid,
      bool? isEnablePassword,
      bool? isEmailSubmitting,
      bool? isPasswordSubmitting,
      bool? isEmailSuccess,
      bool? isEmailFailure,
      bool? isFailure,
      bool? isSuccess,
      bool? isFailureConnection}) {
    return LoginState(
      isEmailFailure: isEmailFailure ?? this.isEmailFailure,
      isEmailSubmitting: isEmailSubmitting ?? this.isEmailSubmitting,
      isEmailSuccess: isEmailSuccess ?? this.isEmailSuccess,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isEnablePassword: isEnablePassword ?? this.isEnablePassword,
      isPasswordSubmitting: isPasswordSubmitting ?? this.isPasswordSubmitting,
      isFailureConnection: isFailureConnection ?? this.isFailureConnection,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  LoginState update(
      {bool? isEmailValid, bool? isPasswordValid, bool? isEnablePassword}) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isEnablePassword: isEnablePassword,
      isEmailFailure: false,
      isEmailSubmitting: false,
      isEmailSuccess: false,
      isPasswordSubmitting: false,
      isSuccess: false,
      isFailureConnection: false,
      isFailure: false,
    );
  }
}
