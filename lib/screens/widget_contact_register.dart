import 'package:agenda_eletronica/components/forms/widget_contact_form.dart';
import 'package:agenda_eletronica/components/widget_contact_preview.dart';
import 'package:agenda_eletronica/screens/widget_common_screen.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';

class ContactRegister extends StatefulWidget {

  const ContactRegister ({Key? key}) : super(key: key);

  @override
  HomeScreeState createState() => HomeScreeState();

}

class HomeScreeState extends State<ContactRegister> with CommonComponent {

  @override
  Widget build(BuildContext context) {
    return content(
      enableBackButton: true,
      title: "Novo Contato",
      child: ListView(
        padding: noEdgeInsets,
        children: [
          Container(
            child: ContactForm(
              feedback: () {},
              subscription: () {},
              cancelOnclick: () {},
            )
          )
        ]
      )
    );
  }
}