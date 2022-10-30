import 'package:flutter/material.dart';

void navigatorPushNamed(context, String routeName, {dynamic arguments, bool ignorePushName = false}) { 

  String? currentRounte = ModalRoute.of(context)!.settings.name; 

  if(currentRounte != routeName || ignorePushName == true ) {
    if(Scaffold.maybeOf(context) != null && Scaffold.maybeOf(context)!.isDrawerOpen) {
      Navigator.of(context).pop();
    }
    Navigator.pushNamed(context, routeName, arguments: arguments);
  } 
} 