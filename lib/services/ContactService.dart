import 'package:agenda_eletronica/entities/contact.dart';
import 'package:agenda_eletronica/helpers.dart';
import 'package:agenda_eletronica/services/Service.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ContactService extends Service {

  ContactService() : super();

  ///
  /// Cadastrar um novo contato
  ///
  Future? registerContact({required Contact contact, String? photo}) async {
    dynamic conn = await dbConn; 

    if(conn == null) {
      return null;
    }

    try {
      final userId = await conn!.rawInsert(
        'INSERT INTO contact(firstName, secondName, email, cpf, photo) VALUES(?, ?, ?, ?, ?)',
        [
          contact.firstName ?? "",
          contact.secondName ?? "",
          contact.email ?? "",
          contact.cpf ?? "",
          ""
        ]
      );

      contact.telephones.forEach((key, value) async {
        String telephone = getNumbers(value['telephone']);
        String type = value['type'];
        await conn!.rawInsert(
          'INSERT INTO telephone(userId, telephone, type) VALUES(?, ?, ?)',
          [
            userId,
            telephone,
            type
          ]
        );
      });

      return true;
    } catch (e) {
      debugPrint(e.toString());
    }


  }

  Future? fetchContacts() async {
    dynamic conn = await dbConn;

    if(conn == null) {
      return null;
    }

    try {
      List<Map> contacts = await conn!.rawQuery(
        'SELECT * FROM contact'
      );

      List<Contact> contactsEntities = [];
     
      for (var value in contacts) {
        contactsEntities.add(
          Contact(
            id: value['id'],
            firstName: value['firstName'],
            secondName: value['secondName'],
            email: value['email'],
            photo: value['photo'],
            cpf: value['cpf'],
            telephones: {}
          )
        );
      }

      return contactsEntities;
    } catch (e) {
      debugPrint("OOOPs!");
      debugPrint(e.toString());
      return null;
    }


  }

  Future? fetchContactById() async {

  }
}