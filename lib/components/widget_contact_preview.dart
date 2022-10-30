import 'package:agenda_eletronica/components/widget_badge.dart';
import 'package:agenda_eletronica/components/widget_contact_photo.dart';
import 'package:agenda_eletronica/components/widget_custom_button.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactPreview extends StatefulWidget {
  const ContactPreview({super.key});

  @override
  ContactPreviewState createState() => ContactPreviewState();
}

class ContactPreviewState extends State<ContactPreview> {

  @override
  Widget build(BuildContext context) {
    return Container(
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
              margin: EdgeInsets.only(
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
                    "Caíque Gabriel",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis
                    )
                  ),
                  Container(
                    child: Row(
                      children: [
                        Badge(
                          margin: const EdgeInsets.only(right: 3),
                          width: 22,
                          height: 22,
                          padding: EdgeInsets.all(2.5),
                          bgColor: primaryLighterColor,
                          textColor: Colors.white,
                          borderRadius: 100,
                          fontSize: 11.7,
                          icon: CupertinoIcons.home,
                        ),
                        Expanded(
                          child: Text(
                            "(88) 9 99345-2282",
                              maxLines: 1,
                              style: TextStyle(
                                color: Color.fromARGB(255, 24, 24, 24),
                                fontSize: 13,
                                fontWeight: FontWeight.w200,
                                overflow: TextOverflow.ellipsis
                              )
                          )
                        )
                      ],
                    )
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
    );
  }

}