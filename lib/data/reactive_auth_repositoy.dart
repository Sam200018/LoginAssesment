import 'dart:async';

import 'package:realauth/auth.dart';

class ReactiveAuthRepository {
  final AuthRepository _authRepository;
  final _controller = StreamController<User>();
  final User user = User(email: "", name: "", password: "");

  ReactiveAuthRepository({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Stream<User> get userStatus async* {
    yield user;
    yield* _controller.stream;
  }

  Future<void> logIn({required String email, required String password}) async {
    final user = await _authRepository.login(email, password);
    _controller.add(user);
  }

  Future<bool> userExists({required String email}) async {
    return await _authRepository.userExists(email);
  }

  void logOut() {
    _controller.add(user);
  }
}
