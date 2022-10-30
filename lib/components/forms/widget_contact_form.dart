import 'package:agenda_eletronica/components/forms/widget_contact_telephone_form.dart';
import 'package:agenda_eletronica/components/widget_custom_button.dart';
import 'package:agenda_eletronica/components/widget_custom_input.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget{ 

  final Function cancelOnclick;

  final Function subscription;

  final Function feedback;

  final bool? hideButtons;

  final Map<String, dynamic>? initialValue; 

  const ContactForm({
    Key? key,
    this.initialValue,
    this.hideButtons,
    required this.feedback,
    required this.cancelOnclick,
    required this.subscription
  }) : super(key: key);

  @override
  ContactFormState createState() => ContactFormState();
} 

class ContactFormState extends State<ContactForm> {

  Map<String, GlobalKey<InputState>> formKeys = {};
  Map<int, GlobalKey<ContactTelephoneFormState>> telephoneKeys = {};
  Map<int, FocusNode> telephoneFocus = {};
  Map<String, FocusNode > formFocus = {};

  List<ContactTelephoneForm> _telephonesForms = [];
 
  void _addTelephoneForm() {
    if (!mounted) return;

    GlobalKey formKey = telephoneKeys[telephoneKeys.length] = GlobalKey();
    FocusNode formFocus = telephoneFocus[telephoneKeys.length] = FocusNode();

    setState(() {
      _telephonesForms.add(
        ContactTelephoneForm(
          inputKey: formKey,
          inputFocus: formFocus,
          toNext: toNext,
          initialValue: "(00) 0 0000-0000",
        )
      );
    });
  }

  @override
  void initState() {
    super.initState();

    formKeys = { 
      'email' : GlobalKey(),
      'firstName' : GlobalKey(),
      'secondName' : GlobalKey(),
      'cpf' : GlobalKey(),
    };

    formFocus = { 
      'email' : FocusNode(),
      'firstName' : FocusNode(),
      'secondName' : FocusNode(),
      'cpf' : FocusNode()
    };

    if (!mounted) return; 

    setState(() { 
      formFocus = formFocus;
      formKeys = formKeys;
    });
  }

  void _onFinalSubmit(){
  //  String email    = formKeys['email']!.currentState!.inputController().text;
  //  String password = formKeys['password']!.currentState!.inputController().text;
    telephoneKeys.forEach((k, v) {
      if (v.currentState != null) {
        if (v.currentState!.enabled) {
          debugPrint("Ativado, valor: " + v.currentState!.getValue()['telephone']);
        } else {
          debugPrint("Não ativo");
        }
      } else {
        debugPrint("Null");
      }
    });
  }
  
  void toNext(GlobalKey currentKey) {
    bool? nextFocus;

    int keys = 0;
    
    formKeys.forEach((key, value) {

      keys++;

      if(nextFocus == true) {
        FocusScope.of(context).requestFocus(formFocus[key]);
        nextFocus = null;
        return;
      }

      if(value == currentKey) { 
        if(formKeys[key]!.currentState!.inputController().text.isNotEmpty) { 
          nextFocus = true;
        }else{
          // O seletor vai pro input atual ainda, já que ele está vazio
          FocusScope.of(context).requestFocus(formFocus[key]);
          return;
        } 
      }

      if(keys == formKeys.length) {
        // Está no último input
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Input(
                  iconColor: Colors.grey, borderRadius: 5,
                  borderColor: Colors.black.withOpacity(0.125),
                  borderWidth: 0,
                  backgroundColor: const Color.fromRGBO(255, 255, 255,  0.95 ),
                  focusNode: formFocus['firstName'],
                  textColor: Colors.black54,
                  formSubmitFunction: toNext,
                  key: formKeys['firstName'],
                  initialValue: widget.initialValue == null ? "" : widget.initialValue!['email'],
                  validatorFunction: (){ },
                  labelColor: Colors.black38,
                  height: 50,
                  hintColor: Colors.black26,
                  icon: CupertinoIcons.person,
                  margin: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
                  hintText: "Caique"
                ),
              ),
              Expanded(
                child: Input(
                  iconColor: Colors.grey, borderRadius: 5,
                  borderColor: Colors.black.withOpacity(0.125),
                  borderWidth: 0,
                  backgroundColor: const Color.fromRGBO(255, 255, 255,  0.95 ),
                  focusNode: formFocus['secondName'],
                  textColor: Colors.black54,
                  formSubmitFunction: toNext,
                  key: formKeys['secondName'],
                  initialValue: widget.initialValue == null ? "" : widget.initialValue!['email'],
                  validatorFunction: (){ },
                  labelColor: Colors.black38,
                  height: 50,
                  hintColor: Colors.black26,
                  icon: CupertinoIcons.person,
                  margin: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                  hintText: "Gabriel"
                ),
              )
            ]
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Input(
                iconColor: Colors.grey, borderRadius: 5,
                borderColor: Colors.black.withOpacity(0.125),
                borderWidth: 0,
                backgroundColor: const Color.fromRGBO(255, 255, 255,  0.95 ),
                focusNode: formFocus['cpf'],
                textColor: Colors.black54,
                formSubmitFunction: toNext,
                key: formKeys['cpf'],
                initialValue: widget.initialValue == null ? "" : widget.initialValue!['email'],
                validatorFunction: (){ },
                labelColor: Colors.black38,
                height: 50,
                hintColor: Colors.black26,
                icon: CupertinoIcons.creditcard_fill,
                margin: const EdgeInsets.only(bottom: 5),
                hintText: "000.000.000-00"
              ),
              Input(
                iconColor: Colors.grey, borderRadius: 5,
                borderColor: Colors.black.withOpacity(0.125),
                borderWidth: 0,
                backgroundColor: const Color.fromRGBO(255, 255, 255,  0.95 ),
                focusNode: formFocus['email'],
                textColor: Colors.black54,
                formSubmitFunction: toNext,
                key: formKeys['email'],
                initialValue: widget.initialValue == null ? "" : widget.initialValue!['email'],
                validatorFunction: (){ },
                labelColor: Colors.black38,
                height: 50,
                hintColor: Colors.black26,
                icon: CupertinoIcons.envelope,
                margin: const EdgeInsets.only(top: 5),
                hintText: "example@email.com"
              ),
            ]
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  width: 200,
                  height: 35,
                  onClick: _addTelephoneForm,
                  text: "Adicionar Telefone",
                  iconSize: 22,
                  fontSize: 15,
                  textColor: primaryColor,
                  iconColor: primaryColor,
                  icon: CupertinoIcons.phone_badge_plus,
                )
              ],
            ),
          ),
          Column(
            children: _telephonesForms,
          ),
          CustomButton(
            margin: const EdgeInsets.all(5),
            onClick: _onFinalSubmit,
            height: 45,
            backgroundColor: primaryColor,
            fontSize: 16,
            textColor: Colors.white,
            icon: CupertinoIcons.add,
            iconSize: 22,
            iconMargin: const EdgeInsets.only(right: 20),
            text: "Registrar Contato",
            borderRadius: BorderRadius.circular(5),
            iconColor: Colors.white.withOpacity(0.5),
          )
        ],
      );
  }

}