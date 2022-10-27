import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:login_test/domain/blocs/auth/auth_bloc.dart';
import 'package:login_test/ui/pages/login/login_page.dart';
import 'package:login_test/ui/pages/new_account/new_account_page.dart';
import 'package:login_test/ui/themes/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Injector.appInstance.get<AuthBloc>(),
      child: const AppView(),
    );
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
              return const EmailPage();
            },
          );
        },
        "/new_account": (context) => const NewAccountPage()
      },
    );
  }
}
