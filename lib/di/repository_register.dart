import 'package:injector/injector.dart';
import 'package:login_test/data/repositories/login/login_repository.dart';

class RepositoryRegister {
  void regist() {
    final injector = Injector.appInstance;

    injector.registerDependency<AuthRepository>(() => AuthRepository());
  }
}
