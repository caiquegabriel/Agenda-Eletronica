import 'package:agenda_eletronica/components/widget_contact_photo.dart';
import 'package:agenda_eletronica/components/widget_details.dart';
import 'package:agenda_eletronica/components/widget_telephone_preview.dart';
import 'package:agenda_eletronica/entities/contact.dart';
import 'package:agenda_eletronica/entities/telephone.dart';
import 'package:agenda_eletronica/screens/widget_common_screen.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/widget_custom_button.dart';
import '../helpers.dart';

class ContactView extends StatefulWidget {

  final Contact contact;

  const ContactView ({Key? key, required this.contact}) : super(key: key);

  @override
  ContactViewState createState() => ContactViewState();

}

class ContactViewState extends State<ContactView> with CommonComponent, AutomaticKeepAliveClientMixin{ 

  @override
  bool get wantKeepAlive => true;

  List<TelephonePreview> _telephones = [];

  @override
  void initState() {
    super.initState();

    for (Telephone telephone in widget.contact.telephones) {
      _telephones.add(TelephonePreview(telephone: telephone));
    }

    setState(() {
      _telephones = _telephones;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return content(
      enableBackButton: true,
      backButtonRoute: '/',
      rightButton: CustomButton(
        width: 45,
        height: 45,
        icon: CupertinoIcons.pen,
        iconSize: 25,
        onClick: () {
          navigatorPushNamed(context, '/contact_edit', arguments: {'contact': widget.contact});
        },
        textColor: primaryColor,
        iconColor: primaryColor,
      ),
      title:"${widget.contact.firstName} ${widget.contact.secondName}",
      child: ListView(
        padding: noEdgeInsets,
        children: [
          Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 30
            ),
            child: ContactPhoto(
              width: 200,
              height: 200,
              avatar: widget.contact.photo,
              borderColor: const Color.fromARGB(255, 203, 203, 203)
            ),
          ),
          Details(
            margin: const EdgeInsets.all(25),
            titleSize: 13,
            titleColor: Colors.black54,
            descriptionColor: Colors.black,
            descriptionSize: 25,
            titleFontWeight: FontWeight.w400,
            items: {
              'Primeiro nome' : widget.contact.firstName,
              'Segundo nome' : widget.contact.secondName,
              'E-mail' : widget.contact.email,
              'CPF' : maskCPF(widget.contact.cpf)
            },
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: const Text(
            "Telefones",
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20
            ),
            child: Column(
              children: _telephones
            )
          )
        ]
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}