import 'package:flutter/material.dart';

class SpacerWidget extends StatelessWidget {
  final double space;

  const SpacerWidget({super.key, required this.space});
  // const Spacer({int space,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space,
    );
  }
}
