import 'package:agenda_eletronica/components/forms/widget_contact_form.dart';
import 'package:agenda_eletronica/entities/contact.dart';
import 'package:agenda_eletronica/providers/contact_provider.dart';
import 'package:agenda_eletronica/screens/widget_common_screen.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactRegister extends StatefulWidget {

  const ContactRegister ({Key? key}) : super(key: key);

  @override
  ContactRegisterState createState() => ContactRegisterState();

}

class ContactRegisterState extends State<ContactRegister> with CommonComponent, AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return content(
      enableBackButton: true,
      title: "Novo Contato",
      child: ListView(
        padding: noEdgeInsets,
        children: [
          ContactForm(
            contact: Contact(),
            onSubmit: Modular.get<ContactProvider>().register,
          )
        ]
      )
    );
  }
}