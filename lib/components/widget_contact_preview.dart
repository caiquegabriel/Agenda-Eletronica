import 'package:agenda_eletronica/components/widget_badge.dart';
import 'package:agenda_eletronica/components/widget_contact_photo.dart';
import 'package:agenda_eletronica/entities/contact.dart';
import 'package:agenda_eletronica/helpers.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactPreview extends StatefulWidget {

  final Contact contact;

  const ContactPreview({super.key, required this.contact});

  @override
  ContactPreviewState createState() => ContactPreviewState();

}

class ContactPreviewState extends State<ContactPreview> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigatorPushNamed(
          context,
          '/contact_view',
          arguments: {'contact': widget.contact}
        );
      },
      child: Container(
        width: double.infinity,
        height: 70,
        margin: const EdgeInsets.only(
          top: 5,
          left: 5,
          right: 5
        ),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.5,
            color: const Color.fromARGB(255, 227, 226, 226)
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [ligthShadow]
        ),
        child: Row(
          children: [
            const ContactPhoto(
              width: 45.5,
              height: 45.5,
              avatar: ""
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10
                ),
                width: double.infinity,
                height: 65,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.contact.firstName} ${widget.contact.secondName}",
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis
                      )
                    ),
                    Row(
                      children: [
                        const Badge(
                          margin: EdgeInsets.only(right: 3),
                          width: 22,
                          height: 22,
                          padding: EdgeInsets.all(2.5),
                          bgColor: Colors.transparent,
                          textColor: primaryColor,
                          borderColor: Colors.transparent,
                          borderRadius: 100,
                          fontSize: 15,
                          icon: CupertinoIcons.home,
                        ),
                        Expanded(
                          child: Text(
                              widget.contact.principalTelephone() ?? "Não disponível",
                              maxLines: 1,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 24, 24, 24),
                                fontSize: 13,
                                fontWeight: FontWeight.w200,
                                overflow: TextOverflow.ellipsis
                              )
                          )
                        )
                      ],
                    )
                  ]
                ),
              )
            ),
            Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100)
              ),
            )
          ],
        ),
      )
    );
  }

}