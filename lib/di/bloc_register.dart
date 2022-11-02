import 'package:injector/injector.dart';
import 'package:login_test/data/reactive_auth_repositoy.dart';
import 'package:login_test/domain/blocs/auth/auth_bloc.dart';
import 'package:login_test/domain/blocs/login/login_bloc.dart';
import 'package:login_test/domain/blocs/new_account/new_account_bloc.dart';
import 'package:realauth/auth.dart';

class BlocRegister {
  void regist() {
    final injector = Injector.appInstance;

    injector.registerSingleton<AuthBloc>(() => AuthBloc(
        reactiveAuthRepository: injector.get<ReactiveAuthRepository>()));
    injector.registerSingleton<LoginBloc>(() =>
        LoginBloc(authRepository: injector.get<ReactiveAuthRepository>()));
    injector.registerSingleton<NewAccountBloc>(() => NewAccountBloc(
          authRepository: injector.get<ReactiveAuthRepository>(),
        ));
  }
}
