import 'dart:io';
import 'dart:math';

import 'package:agenda_eletronica/components/forms/widget_contact_telephone_form.dart';
import 'package:agenda_eletronica/components/widget_contact_photo.dart';
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
import 'package:path_provider/path_provider.dart';

class ContactForm extends StatefulWidget{ 

  final Function onSubmit;

  final Contact contact; 

  const ContactForm({
    Key? key,
    required this.contact,
    required this.onSubmit
  }) : super(key: key);

  @override
  ContactFormState createState() => ContactFormState();
} 

class ContactFormState extends State<ContactForm> {

  /// Localização da foto do contato
  String _imagePath = "";
  GlobalKey<ContactPhotoState> contactPhotoKey = GlobalKey();

  /// Chaves do formulário
  Map<String, GlobalKey<InputState>> formKeys = {};

  Map<int, FocusNode> telephoneFocus = {};
  Map<String, FocusNode > formFocus = {};

  /// Chaves do formulário dos telefones
  Map<int, GlobalKey<ContactTelephoneFormState>> telephoneFormKeys = {};

  /// Formulários do telefones
  final List<ContactTelephoneForm> _telephonesForms = [];

  /// Valores dos telefones
  List<Telephone> telephonesValues = [];

  /// Máscara do CPF
  MaskTextInputFormatter? _maskCPF;

  void _loadTelephones() {
    if (widget.contact.telephones.isEmpty || !mounted) return;

    for (Telephone t in widget.contact.telephones) {
      _addTelephoneForm(telephone: t);
    }
  }
 
  void _addTelephoneForm({Telephone? telephone}) {
    if (!mounted) return;

    GlobalKey formKey = telephoneFormKeys[telephoneFormKeys.length] = GlobalKey();
    FocusNode inputFocus = telephoneFocus[telephoneFormKeys.length] = FocusNode();

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

    _maskCPF = MaskTextInputFormatter(
      mask: '###.###.###-##', 
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy,
      initialText: widget.contact.cpf
    );

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
      _imagePath = widget.contact.photo ?? "";
      _maskCPF = _maskCPF;
    });
  }

  void _onFinalSubmit() {

    String firstName = formKeys['firstName']!.currentState!.inputController().text;
    String secondName = formKeys['secondName']!.currentState!.inputController().text;
    String cpf = formKeys['cpf']!.currentState!.inputController().text;
    String email = formKeys['email']!.currentState!.inputController().text;

    if (firstName.isEmpty || secondName.isEmpty) {
      customDialog(
        context,
        title: "Nome e/ou Sobrenome vazios!",
        description: "O Nome e Sobrenome não podem ser vazios."
      );
      return;
    }

    if (!CPFValidator.isValid(cpf)) {
      customDialog(
        context,
        title: "CPF inválido!",
        description: "O CPF inserido é inválido."
      );
      return;
    }

    if (!isEmail(email)) {
      customDialog(
        context,
        title: "E-mail inválido!",
        description: "O e-mail inserido é inválido."
      );
      return;
    }

    telephonesValues = [];
    telephoneFormKeys.forEach((k, v) {
      if (v.currentState != null) {
        if (v.currentState!.enabled) {
          Map value = v.currentState!.getValue();
          if (value['telephone'] != null && value['telephone'].isNotEmpty) {
            value['telephone'] = getNumbers(value['telephone']);
            if (value['telephone'].split('').length < 8) {
              customDialog(
                context,
                title: "Algum telefone da lista é inválido.",
                description: "O telefone tem que ter pelo menos 8 números."
              );
              telephonesValues = [];
              return;
            }
            telephonesValues.add(
              Telephone(
                type: value['type'],
                telephone: value['telephone'],
              )
            );
          }
        }
      }
    });

    if (telephonesValues.isEmpty) {
      customDialog(
        context,
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
      telephones: telephonesValues,
      photo: _imagePath
    );

    widget.onSubmit(contact).then((results) {
      if (results != true && results != null) {
        contact.id = results;
      }
      customDialog(
        context,
        title: widget.contact.id != null ? "Dados atualizados!" : "Contato criado!",
        description: widget.contact.id != null ? "As informações de ${widget.contact.firstName} foram atualizadas com sucesso!" : "Um novo contato foi salvo.",
        callback: () {
          navigatorPushNamed(context, '/contact_view', arguments: {'contact': contact});
        }
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
    ImagePicker picker = ImagePicker();

    try{
      await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 35
      ).then((pickedFile) async {
        if(pickedFile != null) {
          int radomId = Random().nextInt(20000000);

          final Directory directory = await getApplicationDocumentsDirectory();
          await File(pickedFile.path).copy('${directory.path}/${widget.contact.id}_$radomId.png');

          setState((){
            _imagePath = '${directory.path}/${widget.contact.id}_$radomId.png';
          });

          contactPhotoKey.currentState!.updateContactPhoto(_imagePath);

          /// Remover a foto anterior do usuário
          if (widget.contact.photo != null) {
            await File(widget.contact.photo!).absolute.delete();
          }
        }
      });
    } catch(e) {
      if (!mounted) return;
    }
  }

  void _removePhoto() async {
    if (widget.contact.photo != null) {
      File(widget.contact.photo!).exists().then((results) async {
        if (results) {
          await File(widget.contact.photo!).absolute.delete();
          contactPhotoKey.currentState!.updateContactPhoto(null);
          setState((){
            _imagePath = "";
            widget.contact.photo = null;
          });
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.only(bottom: 20),
            child: Stack (
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
                  child: ContactPhoto(
                    key: contactPhotoKey,
                    avatar: _imagePath
                  ),
                ),
                (_imagePath.isNotEmpty && (widget.contact.photo != null))
                  ?
                    Positioned(
                      left: 5,
                      bottom: 5,
                      child: CustomButton(
                        width: 45,
                        height: 45,
                        borderRadius: BorderRadius.circular(1000),
                        backgroundColor: Colors.red,
                        icon: CupertinoIcons.trash,
                        iconColor: Colors.white,
                        iconSize: 20,
                        onClick: _removePhoto,
                      )
                    )
                  :
                    const SizedBox.shrink(),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: CustomButton(
                    width: 45,
                    height: 45,
                    borderRadius: BorderRadius.circular(1000),
                    backgroundColor: primaryLighterColor,
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
                  hintText: "Segundo Nome"
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
                mask: _maskCPF != null ? [_maskCPF!] : null,
                textColor: Colors.black54,
                formSubmitFunction: toNext,
                key: formKeys['cpf'],
                initialValue: widget.contact.cpf != null && _maskCPF != null ? _maskCPF!.updateMask(mask: "###.###.###-##").text : "",
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
            margin: const EdgeInsets.only(
              top: 10,
              bottom: 20
            ),
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
            child: SafeArea(
              top: false,
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
          )
        ],
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}