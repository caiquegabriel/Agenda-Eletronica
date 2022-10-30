import 'package:agenda_eletronica/entities/contact.dart';
import 'package:agenda_eletronica/entities/telephone.dart';
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

      for (Telephone t in contact.telephones) {
        String telephone = getNumbers(t.telephone ?? "");
        String type =t.type ?? "residencial";
        await conn!.rawInsert(
          'INSERT INTO telephone(userId, telephone, type) VALUES(?, ?, ?)',
          [
            userId,
            telephone,
            type
          ]
        );
      }

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
     
      for (var contact in contacts) {
        List<Telephone>? telephones = await fetchTelephonesByUserId(contact['id']);
        contactsEntities.add(
          Contact(
            id: contact['id'],
            firstName: contact['firstName'],
            secondName: contact['secondName'],
            email: contact['email'],
            photo: contact['photo'],
            cpf: contact['cpf'],
            telephones: telephones ?? <Telephone>[]
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

  Future? fetchTelephonesByUserId(int userId) async {

    dynamic conn = await dbConn;

    if(conn == null) {
      return null;
    }

    try {
      List<Map> telephones = await conn!.rawQuery(
        'SELECT * FROM telephone WHERE userId = ?',
        [userId]
      );

      List<Telephone> telephonesList = [];

      for (var telephone in telephones) {
        telephonesList.add(
          Telephone(
            id: telephone['id'],
            telephone: telephone['telephone'],
            type: telephone['type'],
            userId: telephone['userId']
          )
        );
      }

      return telephonesList;
    } catch (e) {
      debugPrint("OOOPs!");
      debugPrint(e.toString());
      return null;
    }
  }
}