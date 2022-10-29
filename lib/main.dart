import 'package:agenda_eletronica/widget_app.dart';
import 'package:agenda_eletronica/widget_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: const App()
    ),
  );
}