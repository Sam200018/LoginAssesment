import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_test/data/repositories/login/login_repository.dart';
import 'package:login_test/domain/validators.dart';

part 'email_event.dart';
part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(EmailState.initialState()) {
    on<EmailChanged>(_onEmailChangedToState);
    on<EmailSubmitted>(_onEmailSubmittedToState);
  }

  final AuthRepository _authRepository;

  void _onEmailChangedToState(
    EmailChanged event,
    Emitter<EmailState> emit,
  ) {
    emit(state.update(isEmailValid: Validators.isValidadEmail(event.email)));
  }

  Future<void> _onEmailSubmittedToState(
    EmailSubmitted event,
    Emitter<EmailState> emit,
  ) async {
    // log(event.email);
    emit(EmailState.loading());
    try {
      final userExist = await _authRepository.userExists(event.email);
      if (userExist) {
        emit(EmailState.success());
      } else {
        emit(EmailState.failure());
      }
    } catch (e) {
      emit(EmailState.failureConecction());
    }
  }
}
