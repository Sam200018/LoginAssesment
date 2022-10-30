import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_test/domain/blocs/auth/auth_bloc.dart';
import 'package:login_test/ui/widgets/custom_text_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CongratsImage(),
              HomeMessage(),
            ],
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: const [LogOutButton()],
    );
  }
}

class CongratsImage extends StatelessWidget {
  const CongratsImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
        "https://i0.wp.com/winkgo.com/wp-content/uploads/2019/11/congratulations-memes-44.gif?w=720&ssl=1");
  }
}

class HomeMessage extends StatelessWidget {
  const HomeMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO:cambiar el nombre por el user
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final name = context.read<AuthBloc>().user.name;
        return CustomText(textC: "Hola, $name", size: 15.0);
      },
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<AuthBloc>().add(LoggedOut()),
      child: const Text("Cerrar Sesion"),
    );
  }
}
