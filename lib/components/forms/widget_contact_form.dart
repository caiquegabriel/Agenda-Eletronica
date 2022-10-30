import 'dart:io';

import 'package:agenda_eletronica/components/forms/widget_contact_telephone_form.dart';
import 'package:agenda_eletronica/components/widget_custom_button.dart';
import 'package:agenda_eletronica/components/widget_custom_input.dart';
import 'package:agenda_eletronica/entities/contact.dart';
import 'package:agenda_eletronica/entities/telephone.dart';
import 'package:agenda_eletronica/helpers.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ContactForm extends StatefulWidget{ 

  final Function onSubmit;

  final Function feedback;

  final Contact contact; 

  const ContactForm({
    Key? key,
    required this.contact,
    required this.feedback,
    required this.onSubmit
  }) : super(key: key);

  @override
  ContactFormState createState() => ContactFormState();
} 

class ContactFormState extends State<ContactForm> {

  bool _waitingPhotoUpload = false;
  bool _sourceCamera = true;

  Map<String, GlobalKey<InputState>> formKeys = {};
  Map<int, GlobalKey<ContactTelephoneFormState>> telephoneKeys = {};
  Map<int, FocusNode> telephoneFocus = {};
  Map<String, FocusNode > formFocus = {};

  List<ContactTelephoneForm> _telephonesForms = [];

  List<Telephone> telephonesValues = [];

  void _loadTelephones() {
    if (widget.contact.telephones.isEmpty || !mounted) return;

    for (Telephone t in widget.contact.telephones) {
      _addTelephoneForm(telephone: t);
    }
  }
 
  void _addTelephoneForm({Telephone? telephone}) {
    if (!mounted) return;

    GlobalKey formKey = telephoneKeys[telephoneKeys.length] = GlobalKey();
    FocusNode inputFocus = telephoneFocus[telephoneKeys.length] = FocusNode();

    setState(() {
      _telephonesForms.add(
        ContactTelephoneForm(
          key: formKey,
          inputFocus: inputFocus,
          toNext: toNext,
          telephoneValue: (telephone != null) ? telephone.telephone ?? "" : "",
          typeValue: (telephone != null) ? telephone.type ?? "trabalho" : "trabalho",
        )
      );
    });
  }

  @override
  void initState() {
    super.initState();

    _loadTelephones();

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

  Future<void> _showMyDialog({required String title, required String description}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Entendi'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onFinalSubmit() {

    String firstName = formKeys['firstName']!.currentState!.inputController().text;
    String secondName = formKeys['secondName']!.currentState!.inputController().text;
    String cpf = formKeys['cpf']!.currentState!.inputController().text;
    String email = formKeys['email']!.currentState!.inputController().text;

    if (firstName.isEmpty || secondName.isEmpty) {
      _showMyDialog(
        title: "Nome e/ou Sobrenome vazios!",
        description: "O Nome e Sobrenome não podem ser vazios."
      );
      return;
    }

    if (!CPFValidator.isValid(cpf)) {
      _showMyDialog(
        title: "CPF inválido!",
        description: "O CPF inserido é inválido."
      );
      return;
    }

    if (!isEmail(email)) {
      _showMyDialog(
        title: "E-mail inválido!",
        description: "O e-mail inserido é inválido."
      );
      return;
    }

    telephonesValues = [];
    telephoneKeys.forEach((k, v) {
      if (v.currentState != null) {
        if (v.currentState!.enabled) {
          Map value = v.currentState!.getValue();
          if (value['telephone'] != null) {
            telephonesValues.add(
              Telephone(
                type: value['type'],
                telephone: value['telephone'],
              )
            );
          } else {
            // Erro no estado do input
          }
        }
      }
    });

    if (telephonesValues.length == 0) {
      _showMyDialog(
        title: "Nenhum telefone inserido.",
        description: "Insira pelo menos um telefone válido!"
      );
      return;
    }

    Contact contact = Contact(
      id: widget.contact.id ?? 0,
      firstName: firstName,
      secondName: secondName,
      email: email,
      cpf: cpf,
      telephones: telephonesValues
    );

    widget.onSubmit(contact).then((results) {
      _showMyDialog(
        title: "Dados atualizados!",
        description: "As informações de ${widget.contact.firstName} foram atualizadas com sucesso!"
      );
      return;
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

  void _newPhoto() async { 

    if(_waitingPhotoUpload == true){ 
      return;
    }

    ImagePicker picker = ImagePicker();
    
    setState((){
    /*  _waitingUpload = true; 
      _base64File = null;
      _imageSelected = false;
      _hasError = false;
      _showOptionsUpload = false;*/
    });

     
    try{
      Future.delayed(Duration(seconds: 60), (){
        if(_waitingPhotoUpload == true) {
        }
      });

      if (_sourceCamera) {
        await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 35
        ).then((pickedFile) {
          if(pickedFile != null) {

            File file = File(pickedFile.path);
            
            // _base64File = base64Encode(file.readAsBytesSync());

            setState((){
            //  _imageSelected = true;
            });

            Future.delayed(const Duration(milliseconds: 200), () {
              if (!mounted) return;

              setState(() {
                _waitingPhotoUpload = false; 
              });  
            });
            
          } else {  
            setState(() {
              _waitingPhotoUpload = false; 
            }); 
          }
        });
      } else {
        await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 35
        ).then((pickedFile) {
          if(pickedFile  != null) {  

            File file = File(pickedFile.path);
            
            //_base64File = base64Encode(file.readAsBytesSync());  

            setState(() {
            //  _imageSelected = true;
            });

            Future.delayed(const Duration(seconds: 1), () {  
              if (!mounted) return;

              setState((){
              //  _keyPhoto.currentState!.updateImage(file); 
              //  _waitingUpload = false; 
              });  
            });
            
          }else{  
            setState((){
            //  _imageSelected = false; 
            //  _waitingUpload = false; 
            }); 
          }
        });
      }
    } catch(e) {
      if (!mounted) return;
      setState(() {
      //  _imageSelected = false; 
      //  _waitingUpload = false; 
      });
    }
  }

  void _removePhoto() {
    if(_waitingPhotoUpload == true) {
      return;
    } 
 
    /*setState((){    
      _keyPhoto.currentState!.removeImage();  
      _waitingUpload = false; 
      _base64File = null;
      _imageSelected = false;
      _showOptionsUpload = true;
    });*/
  }


  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 260,
            child:  Stack (
              children: [
                Container (
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.125),
                    border: Border.all(
                      width: 1,
                      color: Colors.black.withOpacity(0.125)
                    ),
                    borderRadius: BorderRadius.circular(1000)
                  ),
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: CustomButton(
                    width: 45,
                    height: 45,
                    borderRadius: BorderRadius.circular(1000),
                    backgroundColor: primaryDarkColor,
                    icon: CupertinoIcons.camera,
                    iconColor: Colors.white,
                    iconSize: 20,
                    onClick: _newPhoto,
                  )
                )
              ],
            ),
          ),
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
                  initialValue: widget.contact.firstName ?? "",
                  validatorFunction: (){ },
                  labelColor: Colors.black38,
                  height: 50,
                  hintColor: Colors.black26,
                  icon: CupertinoIcons.person,
                  margin: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
                  hintText: "Primeiro Nome"
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
                  initialValue: widget.contact.secondName ?? "",
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
                mask: [
                  MaskTextInputFormatter(
                    initialText: widget.contact.cpf.toString(),
                    mask: '###.###.###-##',
                    filter: { "#": RegExp(r'[0-9]') },
                    type: MaskAutoCompletionType.eager
                  )
                ],
                textColor: Colors.black54,
                formSubmitFunction: toNext,
                key: formKeys['cpf'],
                initialValue: widget.contact.cpf ?? "",
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
                initialValue: widget.contact.email ?? "",
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
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  width: 200,
                  margin: const EdgeInsets.all(5),
                  onClick: _onFinalSubmit,
                  height: 45,
                  backgroundColor: primaryColor,
                  fontSize: 16,
                  textColor: Colors.white,
                  icon: CupertinoIcons.add,
                  iconSize: 22,
                  iconMargin: const EdgeInsets.only(right: 20),
                  text: widget.contact.id != null ? "Atualizar" : "Salvar Contato",
                  borderRadius: BorderRadius.circular(5),
                  iconColor: Colors.white.withOpacity(0.5),
                )
              ],
            )
          )
        ],
      );
  }

}