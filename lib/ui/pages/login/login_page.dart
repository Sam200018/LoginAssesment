import 'package:flutter/material.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: const [
                PrincipalImage(),
                EmailInput(),
                // EmailCheckButton(),
                // NewAccountButton(),
              ],
            ),
          ),
        ),
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

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      decoration:
          const InputDecoration(labelText: "email", hintText: "foo@bar.com"),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
