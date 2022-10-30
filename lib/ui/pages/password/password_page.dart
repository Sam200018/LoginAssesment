import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_test/domain/blocs/login/login_bloc.dart';
import 'package:login_test/ui/widgets/custom_text_widget.dart';
import 'package:login_test/ui/widgets/principal_image_widget.dart';
import 'package:login_test/ui/widgets/spacer_widget.dart';

class PasswordPage extends StatelessWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: CustomText(
                    textC: "Las credenciales son incorrectas", size: 15.0),
              ),
            );
        }
        if (state.isSuccess) {
          Navigator.pushReplacementNamed(context, "/");
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: const [
                PrincipalImage(),
                SpacerWidget(space: 16),
                PasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordForm extends StatelessWidget {
  const PasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        PasswordInput(),
        SpacerWidget(space: 16),
        LoginButton(),
      ],
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});
  bool isEnablePassword(LoginState state) => state.isEnablePassword;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          controller: context.read<LoginBloc>().passwordController,
          autocorrect: false,
          obscureText: !isEnablePassword(state),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const SuffixIconWidget(),
              onPressed: () =>
                  context.read<LoginBloc>().add(PasswordActivated()),
            ),
            labelText: "password",
            errorText: (!state.isPasswordValid) ? "password no valida" : null,
          ),
          keyboardType: TextInputType.text,
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged());
          },
        );
      },
    );
  }
}

class SuffixIconWidget extends StatelessWidget {
  const SuffixIconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
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

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  bool isPasswordInputValid(LoginState state) => state.isPasswordValid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.isPasswordSubmiting) {
          return const CircularProgressIndicator();
        } else {
          return SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
              onPressed: isPasswordInputValid(state)
                  ? () => context.read<LoginBloc>().add(PasswordSubmitted())
                  : null,
              child: const CustomText(textC: "Iniciar sesion", size: 20.0),
            ),
          );
        }
      },
    );
  }
}
