import 'package:injector/injector.dart';
import 'package:login_test/domain/blocs/auth/auth_bloc.dart';

class BlocRegister {
  void regist() {
    final injector = Injector.appInstance;

    injector.registerSingleton<AuthBloc>(() => AuthBloc());
  }
}
