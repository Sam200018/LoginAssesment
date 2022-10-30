import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:login_test/domain/blocs/auth/auth_bloc.dart';
import 'package:login_test/domain/blocs/login/login_bloc.dart';
import 'package:login_test/ui/pages/login/email_page.dart';
import 'package:login_test/ui/pages/new_account/new_account_page.dart';
import 'package:login_test/ui/themes/theme.dart';

import 'ui/pages/home/home_page.dart';
import 'ui/pages/password/password_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(value: Injector.appInstance.get<AuthBloc>()),
      BlocProvider.value(value: Injector.appInstance.get<LoginBloc>()),
    ], child: const AppView());
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      initialRoute: "/",
      routes: {
        "/": (context) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return const HomePage();
              } else {
                return const EmailPage();
              }
            },
          );
        },
        "/new_account": (context) {
          return BlocProvider.value(
            value: Injector.appInstance.get<LoginBloc>(),
            child: const NewAccountPage(),
          );
        },
        "/password": (context) => const PasswordPage(),
      },
    );
  }
}
