import 'package:injector/injector.dart';
import 'package:login_test/data/repositories/login/login_repository.dart';
import 'package:login_test/domain/blocs/auth/auth_bloc.dart';
import 'package:login_test/domain/blocs/login/login_bloc.dart';

class BlocRegister {
  void regist() {
    final injector = Injector.appInstance;

    injector.registerSingleton<AuthBloc>(() => AuthBloc());
    injector.registerSingleton<LoginBloc>(() => LoginBloc(
        authRepository: injector.get<AuthRepository>(),
        authBloc: injector.get<AuthBloc>()));
  }
}
