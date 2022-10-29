import 'package:agenda_eletronica/screens/widget_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {

   @override
  List<Bind> get binds => [
  //  Bind((i) => Cart(), isSingleton: true)
  ];

  /// rotas do módulo 
  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      '/',
      child: (context, args) => const HomeScreen(),
      transition: TransitionType.noTransition
    ),
  ];
}