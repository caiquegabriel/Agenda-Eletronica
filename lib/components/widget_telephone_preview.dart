import 'package:agenda_eletronica/entities/telephone.dart';
import 'package:agenda_eletronica/helpers.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TelephonePreview extends StatefulWidget {

  final Telephone telephone;

  const TelephonePreview({super.key, required this.telephone});

  @override
  TelephonePreviewState createState() => TelephonePreviewState();

}

class TelephonePreviewState extends State<TelephonePreview> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
          color: Colors.grey.withOpacity(0.125)
        ),
        boxShadow: const [ligthShadow],
        borderRadius: BorderRadius.circular(10)
      ),
      child: InkWell(
        onTap: () {
          launch("tel://${widget.telephone.telephone}");
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.telephone.type!.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              maskTelephone(widget.telephone.telephone),
              style: const TextStyle(
                fontSize: 22,
                color: primaryColor
              ),
            )
          ]
        )
      )
    );

  }
}