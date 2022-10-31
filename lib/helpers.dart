import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

void navigatorPushNamed(context, String routeName, {dynamic arguments, bool ignorePushName = false}) { 

  String? currentRounte = ModalRoute.of(context)!.settings.name; 

  if(currentRounte != routeName || ignorePushName == true ) {
    if(Scaffold.maybeOf(context) != null && Scaffold.maybeOf(context)!.isDrawerOpen) {
      Navigator.of(context).pop();
    }
    Navigator.pushNamed(context, routeName, arguments: arguments);
  } 
} 

///
/// Retorna apenas os números presente da String
///
String getNumbers(String value) {
  return value.replaceAll(RegExp(r'[^0-9]'),'');
}


///
/// Validações
///
bool isEmail(String email) {
  RegExp regExp = RegExp( r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  return regExp.hasMatch(email);
}

///
/// Mascaras
///
String maskTelephone(String? telephone) {
  if (telephone == null) return "";

  MaskTextInputFormatter telephoneMask = MaskTextInputFormatter(
    mask: '(##) # ####-####', 
    filter: { "#": RegExp(r'[0-9]') },
  );

  return telephoneMask.maskText(telephone);
}

String maskCPF(String? cpf) {
  if (cpf == null) return "";

  MaskTextInputFormatter cpfMask = MaskTextInputFormatter(
    mask: '###.###.###-##', 
    filter: { "#": RegExp(r'[0-9]') },
  );

  return cpfMask.maskText(cpf);
}

///
/// Dialogos
///


Future<void> customDialog(context, {required String title, required String description, Function? callback, bool? showCancelButton}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description)
              ],
            ),
          ),
          actions: <Widget>[
            (callback != null && showCancelButton == true)
            ?
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            :
              const SizedBox.shrink(),
            TextButton(
              child: const Text('Entendi'),
              onPressed: () {
                Navigator.of(context).pop();
                if (callback != null) {
                  callback();
                }
              },
            ),
          ],
        );
      },
    );
  }