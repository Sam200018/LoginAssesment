part of 'new_account_bloc.dart';

class NewAccountState extends Equatable {
  final bool isNameValid,
      isEmailValid,
      isPasswordValid,
      isEnablePassword,
      isSubmitting,
      isFailure,
      isSuccess,
      isFailureConnection;

  const NewAccountState({
    required this.isNameValid,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isEnablePassword,
    required this.isSubmitting,
    required this.isFailure,
    required this.isSuccess,
    required this.isFailureConnection,
  });

  @override
  List<Object> get props => [
        isNameValid,
        isEmailValid,
        isPasswordValid,
        isEnablePassword,
        isSubmitting,
        isFailure,
        isSuccess,
        isFailureConnection
      ];

  bool get formValid => isEmailValid && isPasswordValid && isNameValid;

  factory NewAccountState.initialState() {
    return const NewAccountState(
      isNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isEnablePassword: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
      isFailureConnection: false,
    );
  }

  factory NewAccountState.isLoading() {
    return const NewAccountState(
      isNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isEnablePassword: false,
      isSubmitting: true,
      isFailure: false,
      isSuccess: false,
      isFailureConnection: false,
    );
  }

  factory NewAccountState.isFailure() {
    return const NewAccountState(
      isNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isEnablePassword: false,
      isSubmitting: false,
      isFailure: true,
      isSuccess: false,
      isFailureConnection: false,
    );
  }

  factory NewAccountState.isSuccess() {
    return const NewAccountState(
      isNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isEnablePassword: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: true,
      isFailureConnection: false,
    );
  }

  factory NewAccountState.isFailureConnection() {
    return const NewAccountState(
      isNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isEnablePassword: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
      isFailureConnection: true,
    );
  }

  NewAccountState copyWith({
    bool? isNameValid,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isEnablePassword,
    bool? isSubmitting,
    bool? isFailure,
    bool? isSuccess,
    bool? isFailureConnection,
  }) {
    return NewAccountState(
      isNameValid: isNameValid ?? this.isNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isEnablePassword: isEnablePassword ?? this.isEnablePassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFailure: isFailure ?? this.isFailure,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailureConnection: isFailureConnection ?? this.isFailureConnection,
    );
  }

  NewAccountState update({
    bool? isNameValid,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isEnablePassword,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isEnablePassword: isEnablePassword,
      isFailure: false,
      isFailureConnection: false,
      isSubmitting: false,
      isSuccess: false,
    );
  }
}
