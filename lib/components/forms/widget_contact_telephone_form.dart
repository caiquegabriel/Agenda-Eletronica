import 'package:agenda_eletronica/components/widget_custom_button.dart';
import 'package:agenda_eletronica/components/widget_custom_input.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ContactTelephoneForm extends StatefulWidget {

  final FocusNode? inputFocus;
  final String? telephoneValue;
  final String? typeValue;
  final Function? toNext;

  const ContactTelephoneForm({super.key, this.inputFocus, this.toNext, this.telephoneValue, this.typeValue});

  @override
  ContactTelephoneFormState createState() => ContactTelephoneFormState();
}


class ContactTelephoneFormState extends State<ContactTelephoneForm> {

  String _telephoneType = "trabalho";

  bool _enabled = true;

  final GlobalKey<InputState> _inputKey = GlobalKey();

  MaskTextInputFormatter? _maskTelephone;

  void hideForm() {
    if (!mounted) return;

    setState(() {
      _enabled = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _maskTelephone = MaskTextInputFormatter(
      mask: '(##) # ####-####', 
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy,
      initialText: widget.telephoneValue
    );

    setState(() {
      _telephoneType = widget.typeValue ?? "trabalho";
      _maskTelephone = _maskTelephone;
    });
  }

  bool get enabled => _enabled;

  Map<String, dynamic> getValue() {
    String? inputValue = null;
    if (_inputKey.currentState != null) {
      inputValue = _inputKey.currentState!.inputController().value.text;
    }
    return {
      'telephone' : inputValue,
      'type' : _telephoneType
    };
  }

  @override
  Widget build(BuildContext context) {

    if (!_enabled) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 60,
      margin: const EdgeInsets.only(
        left: 5,
        right: 5,
        bottom: 5
      ),
      padding: const EdgeInsets.only(
        left: 6,
        right: 6,
        top: 3.5,
        bottom: 3.5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: const Color.fromARGB(255, 234, 232, 232)
        ),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        children: [
          CustomButton(
            borderRadius: BorderRadius.circular(100),
            margin: const EdgeInsets.only(left: 3.5, right: 3.5),
            width: 17,
            height: 17,
            backgroundColor: Colors.red,
            fontSize: 13,
            iconSize: 11,
            iconColor: Colors.white,
            icon: CupertinoIcons.minus,
            onClick: hideForm,
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(right: 7),
            width: 100,
            child: DropdownButton<String>(
              value: _telephoneType,
              underline: Container(
                height: 1,
                color: Colors.transparent,
              ),
              icon: const Icon(
                CupertinoIcons.chevron_down,
                color: primaryColor,
                size: 15
              ),
              elevation: 13,
              style: const TextStyle(
                color: primaryColor,
                overflow: TextOverflow.ellipsis
              ),
              onChanged: (String? value) {
                if (!mounted) return;
                setState(() {
                  _telephoneType = value ?? "trabalho";
                });
              },
              items: ["trabalho", "celular", "residencial"].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(2.5),
                    height: 45,
                    width: 85,
                    child: Text(
                      value.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  )
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Input(
              iconColor: Colors.grey,
              borderRadius: 5,
              borderColor: Colors.transparent,
              borderWidth: 0.25,
              backgroundColor: const Color.fromRGBO(255, 255, 255,  0.95),
              focusNode: widget.inputFocus,
              textColor: Colors.black,
              textWeight: FontWeight.w600,
              formSubmitFunction: widget.toNext,
              mask: _maskTelephone != null ? [
                _maskTelephone!
              ] : null,
              key: _inputKey,
              initialValue: widget.telephoneValue != null && _maskTelephone != null ? _maskTelephone!.updateMask(mask: "(##) # ####-####").text : "",
              validatorFunction: (){},
              iconHeight: 35,
              height: 45,
              fontSize: 15,
              hintColor: Colors.black26,
              icon: CupertinoIcons.device_phone_portrait,
              margin: const EdgeInsets.only(
                right: 5,
                top: 5,
                bottom: 5
              ),
              hintText: "(00) 0 0000-0000",
            )
          )
        ],
      )
    );
  }
}