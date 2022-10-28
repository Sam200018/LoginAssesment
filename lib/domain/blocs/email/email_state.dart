part of 'email_bloc.dart';

class EmailState extends Equatable {
  final bool isEmailValid,
      isSubmiting,
      isSuccess,
      isFailure,
      isFailureConnection;

  const EmailState({
    required this.isEmailValid,
    required this.isSubmiting,
    required this.isSuccess,
    required this.isFailure,
    required this.isFailureConnection,
  });

  @override
  List<Object> get props => [isEmailValid, isSubmiting, isSuccess, isFailure];

  bool get emailInputValid => isEmailValid;

  factory EmailState.initialState() {
    return const EmailState(
      isEmailValid: true,
      isSubmiting: false,
      isSuccess: false,
      isFailureConnection: false,
      isFailure: false,
    );
  }

  factory EmailState.loading() {
    return const EmailState(
        isEmailValid: true,
        isSubmiting: true,
        isSuccess: false,
        isFailureConnection: false,
        isFailure: false);
  }

  factory EmailState.failure() {
    return const EmailState(
        isEmailValid: true,
        isSubmiting: false,
        isSuccess: false,
        isFailureConnection: false,
        isFailure: true);
  }

  factory EmailState.success() {
    return const EmailState(
        isEmailValid: true,
        isSubmiting: false,
        isSuccess: true,
        isFailureConnection: false,
        isFailure: false);
  }

  factory EmailState.failureConecction() {
    return const EmailState(
        isEmailValid: true,
        isSubmiting: false,
        isSuccess: false,
        isFailureConnection: true,
        isFailure: false);
  }

  EmailState copyWith({
    bool? isEmailValid,
    bool? isSubmiting,
    bool? isSuccess,
    bool? isFailureConnection,
    bool? isFailure,
  }) {
    return EmailState(
      isFailureConnection: isFailureConnection ?? this.isFailureConnection,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isSubmiting: isSubmiting ?? this.isSubmiting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  EmailState update({bool? isEmailValid}) {
    return copyWith(
      isEmailValid: isEmailValid,
      isSubmiting: false,
      isSuccess: false,
      isFailureConnection: false,
      isFailure: false,
    );
  }
}
