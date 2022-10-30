import 'package:agenda_eletronica/components/forms/widget_contact_form.dart';
import 'package:agenda_eletronica/entities/contact.dart';
import 'package:agenda_eletronica/screens/widget_common_screen.dart';
import 'package:agenda_eletronica/services/ContactService.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactView extends StatefulWidget {

  final Contact contact;

  const ContactView ({Key? key, required this.contact}) : super(key: key);

  @override
  ContactViewState createState() => ContactViewState();

}

class ContactViewState extends State<ContactView> with CommonComponent {

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
  }

  @override
  Widget build(BuildContext context) {
    return content(
      enableBackButton: true,
      title:"${widget.contact.firstName} ${widget.contact.secondName}",
      child: ListView(
        padding: noEdgeInsets,
        children: [
          Container(
            child: ContactForm(
              contact: widget.contact,
              feedback: () {},
              onSubmit: onSubmit,
            )
          )
        ]
      )
    );
  }
}