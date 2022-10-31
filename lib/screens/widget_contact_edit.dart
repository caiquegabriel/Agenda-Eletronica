import 'package:agenda_eletronica/components/forms/widget_contact_form.dart';
import 'package:agenda_eletronica/entities/contact.dart';
import 'package:agenda_eletronica/providers/contact_provider.dart';
import 'package:agenda_eletronica/screens/widget_common_screen.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../components/widget_custom_button.dart';
import '../helpers.dart';

class ContactEdit extends StatefulWidget {

  final Contact contact;

  const ContactEdit ({Key? key, required this.contact}) : super(key: key);

  @override
  ContactEditState createState() => ContactEditState();

}

class ContactEditState extends State<ContactEdit> with CommonComponent {

  Future onSubmit(Contact contact) {
    return Modular.get<ContactProvider>().udpdateContact(contact);
  }

  void _removeContact() {
    Modular.get<ContactProvider>().removeContact(widget.contact).then((results) {
      if (results == true) {
        customDialog(
          context,
          title: "Contato removido",
          description: "O contato ${widget.contact.firstName} foi removido.",
          callback: () {
            navigatorPushNamed(context, '/');
          }
        );
      } else {
        customDialog(
          context,
          title: "Houve uma falha ao remover contato.",
          description: "O contato de ${widget.contact.firstName} provavelmente não foi removido.",
          callback: () {
          //  navigatorPushNamed(context, '/');
          }
        );
      }
    });
  }

  void onRemove() {
    customDialog(
      context,
      title: "Deseja remover o contato de ${widget.contact.firstName} ?",
      description: "Esta ação não poderá ser desfeita!",
      showCancelButton: true,
      callback: _removeContact
    );
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