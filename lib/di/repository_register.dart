import 'package:injector/injector.dart';
import 'package:login_test/data/reactive_auth_repositoy.dart';
import 'package:realauth/auth.dart';

class RepositoryRegister {
  void regist() {
    final injector = Injector.appInstance;

    injector.registerDependency<AuthRepository>(() => AuthRepository());
    injector.registerSingleton<ReactiveAuthRepository>(() =>
        ReactiveAuthRepository(authRepository: injector.get<AuthRepository>()));
  }
}
