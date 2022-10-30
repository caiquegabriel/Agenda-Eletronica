import 'package:agenda_eletronica/components/forms/widget_contact_form.dart';
import 'package:agenda_eletronica/entities/contact.dart';
import 'package:agenda_eletronica/providers/contact_provider.dart';
import 'package:agenda_eletronica/screens/widget_common_screen.dart';
import 'package:agenda_eletronica/services/ContactService.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../components/widget_custom_button.dart';
import '../helpers.dart';

class ContactView extends StatefulWidget {

  final Contact contact;

  const ContactView ({Key? key, required this.contact}) : super(key: key);

  @override
  ContactViewState createState() => ContactViewState();

}

class ContactViewState extends State<ContactView> with CommonComponent {

  void onSubmit(Contact contact, {Uint8List? photo}) {
    Modular.get<ContactProvider>().udpdateContact(contact);
  }

  void onRemove() {
   Modular.get<ContactProvider>().removeContact(widget.contact);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return content(
      enableBackButton: true,
      rightButton: CustomButton(
        width: 45,
        height: 45,
        icon: CupertinoIcons.trash,
        iconSize: 25,
        onClick: onRemove,
        textColor: primaryColor,
        iconColor: primaryColor,
      ),
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