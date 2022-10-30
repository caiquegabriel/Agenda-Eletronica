import 'dart:convert';

import 'package:agenda_eletronica/entities/telephone.dart';
import 'package:flutter/material.dart';

class Contact {

  int? _id;
  String? _firstName;
  String? _secondName;
  String? _email;
  String? _cpf;
  String? _photo;
  List<Telephone> _telephones = [];

  Contact ({
    int? id,
    String? firstName,
    String? secondName,
    String? email,
    String? cpf,
    String photo = "",
    List<Telephone> telephones = const <Telephone>[]
  }) {
    _id = id;
    _firstName = firstName;
    _secondName = secondName;
    _email = email;
    _photo = photo;
    _telephones = telephones;
    _cpf = cpf;
  }

  String? get firstName => _firstName;

  String? get secondName => _secondName;

  String? get photo => _photo;

  String? get email => _email;

  int? get id => _id;

  String? get cpf => _cpf;

  List<Telephone> get telephones => _telephones;

  String? principalTelephone() {
    String? principalTelephone;
    for (var telephone in _telephones) {
      if (telephone.type == "residencial") {
        principalTelephone = telephone.telephone;
        break;
      }
    }

    return principalTelephone;
  }

  Map<String, dynamic> toJson() => {
    'firstName' : _firstName ?? "",
    'email' : _email ?? "",
    'secondName' : _secondName ?? "",
    'cpf': _cpf ?? "",
    'id' : _id ?? 0,
    'telephone' : const JsonEncoder().convert(_telephones)
  };

}