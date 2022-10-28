import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String textC;
  final double size;

  const CustomText({super.key, required this.textC, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      textC,
      style: TextStyle(
        color: Colors.black,
        fontSize: size,
      ),
    );
  }
}
