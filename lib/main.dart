import 'package:flutter/material.dart';
import 'package:login_test/di/bloc_register.dart';
import 'package:login_test/di/repository_register.dart';

import 'app.dart';

void main() {
  BlocRegister().regist();
  RepositoryRegister().regist();
  runApp(const MyApp());
}
