import 'package:agenda_eletronica/components/widget_custom_button.dart';
import 'package:agenda_eletronica/screens/widget_common_screen.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TemplateHeader extends StatefulWidget {

  const TemplateHeader ({super.key});

  @override
  TemplateHeaderState createState() => TemplateHeaderState();
}

class TemplateHeaderState extends State<TemplateHeader> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7.5),
      height: headerHeight + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        color: primaryColor,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(0.06)
          )
        )
      ),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Container(
          height: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Agenda",
                    style: TextStyle(
                      fontSize: 20.7,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.127
                    ),
                  ),
                )
              ),
              const CustomButton(
                width: 45,
                height: 45,
                icon: CupertinoIcons.add,
                iconSize: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}