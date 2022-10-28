import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:login_test/domain/blocs/email/email_bloc.dart';
import 'package:login_test/ui/widgets/custom_text_widget.dart';
import 'package:login_test/ui/widgets/spacer_widget.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailBloc, EmailState>(
      listener: (context, state) {
        if (state.isFailure) {
          showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: Injector.appInstance.get<EmailBloc>(),
              child: AlertDialog(
                title:
                    const CustomText(textC: "El email no existe", size: 15.0),
                content: const Icon(
                  Icons.error,
                  size: 20.0,
                  color: Colors.red,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Volver a intentar"),
                  ),
                  TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, "/new_account"),
                      child: const Text("Crear nueva cuenta"))
                ],
              ),
            ),
          );
        }
        if (state.isFailureConnection) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: CustomText(textC: "Fallo en la conexion", size: 15.0),
              ),
            );
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

class PrincipalImage extends StatelessWidget {
  const PrincipalImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(image: AssetImage("images/accountImage.png"));
  }
}

class EmailForm extends StatefulWidget {
  const EmailForm({Key? key}) : super(key: key);

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailInput(
          emailController: _emailController,
        ),
        const SpacerWidget(space: 16),
        EmailCheckButton(
          emailInput: _emailController,
        ),
      ],
    );
  }
}

class EmailInput extends StatelessWidget {
  final TextEditingController emailController;
  const EmailInput({required this.emailController, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailBloc, EmailState>(
      builder: (context, state) {
        return TextFormField(
          controller: emailController,
          autocorrect: false,
          decoration: InputDecoration(
            labelText: "email",
            hintText: "foo@bar.com",
            errorText: (!state.isEmailValid) ? "email invalido" : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) {
            context.read<EmailBloc>().add(EmailChanged(email: email));
          },
        );
      },
    );
  }
}

class EmailCheckButton extends StatelessWidget {
  final TextEditingController emailInput;

  const EmailCheckButton({required this.emailInput, super.key});

  bool isEmailInputValid(EmailState state) => state.emailInputValid;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailBloc, EmailState>(
      builder: (context, state) {
        if (state.isSubmiting) {
          return const CircularProgressIndicator();
        } else {
          return SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
              onPressed: isEmailInputValid(state)
                  ? () => context
                      .read<EmailBloc>()
                      .add(EmailSubmitted(email: emailInput.text))
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
        onPressed: () => Navigator.pushNamed(context, "/new_account"),
        child: const Text("Crear Sesion"));
  }
}
