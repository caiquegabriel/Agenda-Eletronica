import 'package:agenda_eletronica/screens/widget_contact_register.dart';
import 'package:agenda_eletronica/screens/widget_home_screen.dart';
import 'package:agenda_eletronica/services/ContactService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {

  @override
  List<Bind> get binds => [
    Bind((i) => ContactService(), isSingleton: true)
  ];

  /// rotas do módulo 
  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      '/contact_register',
      child: (context, args) => const HomeScreen(),
      transition: TransitionType.noTransition
    ),
    ChildRoute(
      '/',
      child: (context, args) => const ContactRegister(),
      transition: TransitionType.noTransition
    ),
  ];
}