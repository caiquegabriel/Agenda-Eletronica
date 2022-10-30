import 'package:flutter/material.dart';
import 'dart:async';

import '../components/template/widget_header.dart';

mixin CommonComponent <T extends StatefulWidget > on State<T> {

  Widget content({Widget? child, String? title, bool? enableBackButton}) {
    return WillPopScope(
      onWillPop: () {  
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true, 
        body: GestureDetector(
          onTap: (){ 
            FocusScope.of(context).requestFocus(FocusNode());
          }, 
          child: Column(
            children: [
              TemplateHeader(title: title, enableBackButton: enableBackButton),
              Expanded(
                child: Container(
                  child: child
                )
              )
            ]
          )
        )
      )
    );
  }

}