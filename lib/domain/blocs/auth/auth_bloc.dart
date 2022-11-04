import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_test/data/reactive_auth_repository.dart';
import 'package:realauth/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ReactiveAuthRepository reactiveAuthRepository;
  late StreamSubscription<User> _userSubscription;

  AuthBloc({required this.reactiveAuthRepository})
      : super(AuthState.unknown()) {
    _userSubscription = reactiveAuthRepository.userStatus.listen(
      (user) {
        if (user.name != "") {
          add(LoggedIn(user: user));
        } else {
          add(LoggedOut());
        }
      },
    );
    on<LoggedIn>(_onLoggedInToState);
    on<LoggedOut>(_onLoggedOutToState);
  }

  void _onLoggedInToState(
    LoggedIn event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthState.authenticated(event.user));
  }

  void _onLoggedOutToState(
    LoggedOut event,
    Emitter<AuthState> emit,
  ) {
    reactiveAuthRepository.logOut;
    emit(AuthState.unknown());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
