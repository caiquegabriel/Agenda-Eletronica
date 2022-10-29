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
      height: 90,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Color.fromARGB(255, 227, 226, 226)
          )
        )
      ),
      child: Row(
        children: [

        ],
      ),
    );
  }

}