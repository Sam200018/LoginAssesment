import 'package:flutter/material.dart';
import 'package:login_test/di/bloc_register.dart';

import 'app.dart';

void main() {
  BlocRegister().regist();
  runApp(const MyApp());
}
