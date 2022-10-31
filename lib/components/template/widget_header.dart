import 'package:agenda_eletronica/components/widget_custom_button.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TemplateHeader extends StatefulWidget {

  final String? title;
  final bool? enableBackButton;
  final CustomButton? rightButton;

  const TemplateHeader ({super.key, this.title, this.enableBackButton, this.rightButton});

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
        color: Colors.white,
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
          margin: noEdgeInsets,
          height: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (widget.enableBackButton == true)
              ?
                CustomButton(
                  width: 45,
                  height: 45,
                  icon: CupertinoIcons.back,
                  textColor: primaryColor,
                  iconColor: primaryColor,
                  iconSize: 25,
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                )
              :
                const SizedBox.shrink(),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    widget.title ?? "Agenda",
                    style: const TextStyle(
                      fontSize: 20.7,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.127
                    ),
                  ),
                )
              ),
              widget.rightButton ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}