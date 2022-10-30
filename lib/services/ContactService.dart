import 'package:agenda_eletronica/data/db/db.dart';
import 'package:agenda_eletronica/entities/contact.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ContactService {

  Future? registerContact({required Contact contact, String? photo}) async {
    dynamic conn = await (DB()).connect(); 

    if(conn == null) {
      return null;
    }

    try {
      final userId = await conn!.rawInsert(
        'INSERT INTO contact(firstName, secondName, email, cpf, photo) VALUES(?, ?, ?, ?, ?)',
        [
          contact.firstName,
          contact.secondName,
          contact.email,
          contact.cpf,
          ""
        ]
      );
      return userId;
    } catch (e) {
      debugPrint(e.toString());
    }


  }

  Future? fetchContacts() async {
    dynamic conn = await (DB()).connect(); 

    if(conn == null) {
      debugPrint("Null");
      return null;
    }

    try {
      List<Map> contacts = await conn!.rawQuery(
        'SELECT * FROM contact'
      );

      List<Contact> contactsEntities = [];
     
      contacts.forEach((value) {
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
      });

      return contactsEntities;
    } catch (e) {
      debugPrint("OOOPs!");
      debugPrint(e.toString());
      return null;
    }


  }

}