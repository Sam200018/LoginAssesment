import 'package:flutter/material.dart';
import 'package:login_test/ui/widgets/custom_text_widget.dart';
import 'package:login_test/ui/widgets/principal_image_widget.dart';
import 'package:login_test/ui/widgets/spacer_widget.dart';

class NewAccountPage extends StatelessWidget {
  const NewAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: const [
              PrincipalImage(),
              SpacerWidget(space: 16),
              NewAccountForm(),
            ],
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: const [LogWithCredentialsButton()],
    );
  }
}

class NewAccountForm extends StatelessWidget {
  const NewAccountForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        EmailInput(),
        SpacerWidget(space: 16),
        EmailInput(),
        SpacerWidget(space: 16),
        CreatAccountButton(),
      ],
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField();
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField();
  }
}

class CreatAccountButton extends StatelessWidget {
  const CreatAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
          onPressed: null,
          child: CustomText(textC: "Crear cuenta", size: 20.0)),
    );
  }
}

class LogWithCredentialsButton extends StatelessWidget {
  const LogWithCredentialsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextButton(
      onPressed: null,
      child: Text("Iniciar sesion con email"),
    );
  }
}
