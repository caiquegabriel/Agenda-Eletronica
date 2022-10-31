import 'package:agenda_eletronica/entities/contact.dart';
import 'package:agenda_eletronica/entities/telephone.dart';
import 'package:agenda_eletronica/helpers.dart';
import 'package:agenda_eletronica/services/cpf_service.dart';
import 'package:agenda_eletronica/services/service.dart';
import 'package:flutter/material.dart';

class ContactService extends Service {

  ContactService() : super();

  ///
  /// Cadastrar um novo contato
  ///
  Future<int?> registerContact({required Contact contact}) async {
    dynamic conn = await dbConn; 

    if(conn == null) {
      return null;
    }

    try {
      final contactId = await conn!.rawInsert(
        'INSERT INTO contact(firstName, secondName, email, cpf, photo) VALUES(?, ?, ?, ?, ?)',
        [
          contact.firstName ?? "",
          contact.secondName ?? "",
          contact.email ?? "",
          contact.cpf ?? "",
          contact.photo
        ]
      );

      for (Telephone t in contact.telephones) {
        String telephone = getNumbers(t.telephone ?? "");
        String type =t.type ?? "residencial";
        await conn!.rawInsert(
          'INSERT INTO telephone(contactId, telephone, type) VALUES(?, ?, ?)',
          [
            contactId,
            telephone,
            type
          ]
        );
      }

      return contactId;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  ///
  /// Pegar contatos
  ///
  Future? fetchContacts() async {
    dynamic conn = await dbConn;

    if(conn == null) {
      return null;
    }

    try {
      List<Map> contacts = await conn!.rawQuery(
        'SELECT * FROM contact ORDER BY firstName ASC, secondName ASC'
      );

      List<Contact> contactsEntities = [];
     
      for (var contact in contacts) {
        List<Telephone>? telephones = await fetchTelephonesByContactId(contact['id']);
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
      debugPrint(e.toString());
      return null;
    }
  }

  ///
  /// Apagar um contato
  ///
  Future? removeContact({required Contact contact}) async {
    dynamic conn = await dbConn; 

    if(conn == null) {
      return null;
    }

    try {
      await conn!.rawInsert(
        'DELETE FROM contact WHERE id = ?',
        [
          contact.id
        ]
      );

      /// Remoção de todos os relefones do usuário
      await conn!.rawInsert(
        'DELETE FROM telephone WHERE contactId = ?',
        [
          contact.id
        ]
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  ///
  /// Atualizar um contato
  ///
  Future? updateContact({required Contact contact}) async {
    dynamic conn = await dbConn; 

    if(conn == null) {
      return null;
    }

    try {
      await conn!.rawInsert(
        'UPDATE contact SET firstName = ?, secondName = ?, email = ?, cpf = ?, photo  = ? WHERE id = ?',
        [
          contact.firstName ??  "",
          contact.secondName ?? "",
          contact.email ?? "",
          contact.cpf ?? "",
          contact.photo,
          contact.id
        ]
      );

      ///
      /// Antes, será feito a remoção de todos os relefones do usuário
      /// Para depois atualizar adicionando os novos telefones
      ///
      await conn!.rawInsert(
        'DELETE FROM telephone WHERE contactId = ?',
        [
          contact.id
        ]
      );

      for (Telephone t in contact.telephones) {
        String telephone = getNumbers(t.telephone ?? "");
        String type =t.type ?? "residencial";
        await conn!.rawInsert(
          'INSERT INTO telephone(contactId, telephone, type) VALUES(?, ?, ?)',
          [
            contact.id,
            telephone,
            type
          ]
        );
      }

      return true;
    } catch (e) {
      return null;
    }
  }

  ///
  /// Pegar telefones para determinado contato
  ///
  Future? fetchTelephonesByContactId(int contactId) async {

    dynamic conn = await dbConn;

    if(conn == null) {
      return null;
    }

    try {
      List<Map> telephones = await conn!.rawQuery(
        'SELECT * FROM telephone WHERE contactId = ?',
        [contactId]
      );

      List<Telephone> telephonesList = [];

      for (var telephone in telephones) {
        telephonesList.add(
          Telephone(
            id: telephone['id'],
            telephone: telephone['telephone'],
            type: telephone['type'],
            contactId: telephone['contactId']
          )
        );
      }

      return telephonesList;
    } catch (e) {
      return null;
    }
  }

  ///
  /// Gera os contatos para o primeiro acesso
  ///
  Future? generateContacts() async {

    var response = await call(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      'GET',
      null
    );

    if (response != null) {
      for (var contact in response) {
        List name = contact['name'].split(' ');
        String firstName = name[0];
        String secondName = name[1];

        await registerContact(
          contact: Contact(
            firstName: firstName,
            secondName: secondName,
            email: contact['email'],
            cpf: await (CPFService()).generateCPF(),
            telephones: [
              Telephone(
                telephone: getNumbers(contact['phone'].split(' ')[0]),
                type: 'trabalho'
              )
            ]
          )
        );
      }

      return true;
    }

    return false;
  }
}