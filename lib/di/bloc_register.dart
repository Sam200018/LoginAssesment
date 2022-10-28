import 'package:injector/injector.dart';
import 'package:login_test/data/repositories/login/login_repository.dart';
import 'package:login_test/domain/blocs/auth/auth_bloc.dart';
import 'package:login_test/domain/blocs/email/email_bloc.dart';

class BlocRegister {
  void regist() {
    final injector = Injector.appInstance;

    injector.registerSingleton<AuthBloc>(() => AuthBloc());
    injector.registerDependency<EmailBloc>(
      () => EmailBloc(
        authRepository: injector.get<AuthRepository>(),
      ),
    );
  }
}
