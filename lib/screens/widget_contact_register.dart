import 'package:agenda_eletronica/components/forms/widget_contact_form.dart';
import 'package:agenda_eletronica/entities/contact.dart';
import 'package:agenda_eletronica/screens/widget_common_screen.dart';
import 'package:agenda_eletronica/services/ContactService.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactRegister extends StatefulWidget {

  const ContactRegister ({Key? key}) : super(key: key);

  @override
  ContactRegisterState createState() => ContactRegisterState();

}

class ContactRegisterState extends State<ContactRegister> with CommonComponent {

  void onSubmit(Contact contact, {Uint8List? photo}) {
    // Chamar Provider, Caique
    debugPrint(contact.firstName.toString());
    debugPrint(contact.secondName.toString());
    debugPrint(contact.cpf.toString());
    debugPrint(contact.email.toString());
    debugPrint(contact.telephones.toString());
    Modular.get<ContactService>().registerContact(contact: contact);
  }

  @override
  void initState() {
    super.initState();
    // (DB()).deleteAllDataBase();
  }

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
              contact: Contact(),
              feedback: () {},
              onSubmit: onSubmit,
            )
          )
        ]
      )
    );
  }
}