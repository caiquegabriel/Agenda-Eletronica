import 'package:agenda_eletronica/components/widget_custom_input.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactTelephoneForm extends StatefulWidget {
  final FocusNode? inputFocus;
  final Key? inputKey;
  final String? initialValue;
  final Function? toNext;

  const ContactTelephoneForm({super.key, this.inputFocus, this.toNext, this.inputKey, this.initialValue});

  @override
  ContactTelephoneFormState createState() => ContactTelephoneFormState();
}


class ContactTelephoneFormState extends State<ContactTelephoneForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: 45,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 234, 229, 229),
              borderRadius: BorderRadius.circular(100)
            ),
            margin: const EdgeInsets.only(right: 10),
            width: 120,
            child: DropdownButton<String>(
              value: "trabalho",
              underline: Container(
                height: 1,
                color: Colors.transparent,
              ),
              icon: const Icon(
                CupertinoIcons.chevron_down,
                color: primaryColor,
                size: 15
              ),
              elevation: 16,
              style: const TextStyle(
                color: primaryColor,
                overflow: TextOverflow.ellipsis
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                //  dropdownValue = value!;
                });
              },
              items: ["trabalho", "celular", "residencial"].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Input(
              iconColor: Colors.grey, borderRadius: 5,
              borderColor: Colors.black.withOpacity(0.125),
              borderWidth: 0,
              backgroundColor: const Color.fromRGBO(255, 255, 255,  0.95 ),
              focusNode: widget.inputFocus,
              textColor: Colors.black54,
              formSubmitFunction: widget.toNext,
              key: widget.inputKey,
              initialValue: widget.initialValue == null ? "" : widget.initialValue!,
              validatorFunction: (){ },
              labelColor: Colors.black38,
              height: 50,
              hintColor: Colors.black26,
              icon: CupertinoIcons.device_phone_portrait,
              margin: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
              hintText: "Caique"
            )
          )
        ],
      )
    );
  }
}