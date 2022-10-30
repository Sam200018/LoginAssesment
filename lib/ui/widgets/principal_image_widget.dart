import 'package:flutter/material.dart';

class PrincipalImage extends StatelessWidget {
  const PrincipalImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(image: AssetImage("images/accountImage.png"));
  }
}
