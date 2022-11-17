import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget())
  );
}