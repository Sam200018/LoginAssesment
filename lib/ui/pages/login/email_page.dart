import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_test/domain/blocs/login/login_bloc.dart';
import 'package:login_test/ui/widgets/custom_text_widget.dart';
import 'package:login_test/ui/widgets/principal_image_widget.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({Key? key}) : super(key: key);

  void stateListener(context, state) {
    if (state.isEmailFailure) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const CustomText(textC: "El email no existe", size: 15.0),
          content: const Icon(
            Icons.error,
            size: 20.0,
            color: Colors.red,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Volver a intentar"),
            ),
            TextButton(
                onPressed: () =>
                    Navigator.popAndPushNamed(context, "/new_account"),
                child: const Text("Crear nueva cuenta"))
          ],
        ),
      );
    }
    if (state.isFailureConnection) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content:
                CustomText(textC: "Se termino el tiempo de espera", size: 15.0),
          ),
        );
    }
    if (state.isEmailSuccess) {
      Navigator.popAndPushNamed(context, "/password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: stateListener,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: const [
                PrincipalImage(),
                SizedBox(height: 16.0),
                EmailForm(),
              ],
            ),
          ),
        ),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: const [NewAccountButton()],
      ),
    );
  }
}

class EmailForm extends StatelessWidget {
  const EmailForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        EmailInput(),
        SizedBox(height: 16.0),
        EmailCheckButton(),
      ],
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          controller: context.read<LoginBloc>().emailController,
          autocorrect: false,
          decoration: InputDecoration(
            labelText: "email",
            hintText: "foo@bar.com",
            errorText: (!state.isEmailValid) ? "email invalido" : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) {
            context.read<LoginBloc>().add(EmailChanged());
          },
        );
      },
    );
  }
}

class EmailCheckButton extends StatelessWidget {
  const EmailCheckButton({super.key});

  bool isEmailInputValid(LoginState state) => state.emailInputValid;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.isEmailSubmitting) {
          return const CircularProgressIndicator();
        } else {
          return SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
              onPressed: isEmailInputValid(state)
                  ? () => context.read<LoginBloc>().add(EmailSubmitted())
                  : null,
              child: const CustomText(textC: "Siguiente", size: 20.0),
            ),
          );
        }
      },
    );
  }
}

class NewAccountButton extends StatelessWidget {
  const NewAccountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.popAndPushNamed(context, "/new_account"),
        child: const Text("Crear Sesion"));
  }
}
