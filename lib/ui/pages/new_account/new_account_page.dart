import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_test/domain/blocs/new_account/new_account_bloc.dart';
import 'package:login_test/ui/widgets/custom_text_widget.dart';
import 'package:login_test/ui/widgets/principal_image_widget.dart';

class NewAccountPage extends StatelessWidget {
  const NewAccountPage({Key? key}) : super(key: key);

  void stateListener(context, state) {
    if (state.isFailure) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: CustomText(textC: "El usuario ya existe", size: 15.0),
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
    if (state.isSuccess) {
      Navigator.popAndPushNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewAccountBloc, NewAccountState>(
      listener: stateListener,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: const [
                PrincipalImage(),
                SizedBox(height: 16.0),
                NewAccountForm(),
              ],
            ),
          ),
        ),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: const [LogWithCredentialsButton()],
      ),
    );
  }
}

class NewAccountForm extends StatelessWidget {
  const NewAccountForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewAccountBloc, NewAccountState>(
      builder: (context, state) {
        return Form(
          key: context.read<NewAccountBloc>().formKey,
          child: Column(
            children: const [
              NameInput(),
              SizedBox(height: 16.0),
              EmailInput(),
              SizedBox(height: 16.0),
              PasswordInput(),
              SizedBox(height: 16.0),
              CreatAccountButton(),
            ],
          ),
        );
      },
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewAccountBloc, NewAccountState>(
      builder: (context, state) {
        return TextFormField(
          autocorrect: false,
          controller: context.read<NewAccountBloc>().nameController,
          decoration: InputDecoration(
            labelText: "name",
            hintText: "Primer Nombre",
            errorText: (!state.isNameValid) ? "nombre no valido" : null,
          ),
          keyboardType: TextInputType.name,
          onChanged: (value) =>
              context.read<NewAccountBloc>().add(NameChanged()),
        );
      },
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewAccountBloc, NewAccountState>(
      builder: (context, state) {
        return TextFormField(
          autocorrect: false,
          controller: context.read<NewAccountBloc>().emailController,
          decoration: InputDecoration(
              labelText: "email",
              hintText: "foo@bar.com",
              errorText: (!state.isEmailValid) ? "emai invalido" : null),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) =>
              context.read<NewAccountBloc>().add(EmailChanged()),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  bool isEnablePassword(NewAccountState state) => state.isEnablePassword;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewAccountBloc, NewAccountState>(
      builder: (context, state) {
        return TextFormField(
          autocorrect: false,
          controller: context.read<NewAccountBloc>().passwordController,
          obscureText: !isEnablePassword(state),
          decoration: InputDecoration(
            labelText: "password",
            hintText:
                "8 caracteres, incluyendo numeros, minisculas, mayusculas y signos",
            errorText: (!state.isPasswordValid) ? "password invalida" : null,
            suffixIcon: IconButton(
                onPressed: () =>
                    context.read<NewAccountBloc>().add(PasswordActivated()),
                icon: const SuffixIconWidget()),
          ),
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) =>
              context.read<NewAccountBloc>().add(PasswordChanged()),
        );
      },
    );
  }
}

class CreatAccountButton extends StatelessWidget {
  const CreatAccountButton({super.key});

  // bool isFormValid(NewAccountState state) => state.formValid ;
  bool isFormValid(NewAccountBloc read, NewAccountState state) =>
      read.emailController.text.isNotEmpty &&
      read.nameController.text.isNotEmpty &&
      read.passwordController.text.isNotEmpty &&
      state.formValid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewAccountBloc, NewAccountState>(
      builder: (context, state) {
        if (state.isSubmitting) {
          return const CircularProgressIndicator();
        } else {
          return SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
                onPressed: isFormValid(context.read<NewAccountBloc>(), state)
                    ? () => context.read<NewAccountBloc>().add(FormSubmitted())
                    : null,
                child: const CustomText(textC: "Crear cuenta", size: 20.0)),
          );
        }
      },
    );
  }
}

class LogWithCredentialsButton extends StatelessWidget {
  const LogWithCredentialsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushReplacementNamed(context, "/"),
      child: const Text("Iniciar sesion con email"),
    );
  }
}

class SuffixIconWidget extends StatelessWidget {
  const SuffixIconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewAccountBloc, NewAccountState>(
      builder: (context, state) {
        if (state.isEnablePassword) {
          return const Icon(Icons.visibility_off_outlined);
        } else {
          return const Icon(Icons.remove_red_eye_outlined);
        }
      },
    );
  }
}
