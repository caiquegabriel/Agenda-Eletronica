import 'package:agenda_eletronica/components/widget_contact_preview.dart';
import 'package:agenda_eletronica/entities/contact.dart';
import 'package:agenda_eletronica/services/ContactService.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {

  final ContactService _contactService = ContactService();

  List<Contact>? _contacts;

  List<ContactPreview>? _contactPreviews;

  List<ContactPreview>? get contactPreviews => _contactPreviews;

  List<Contact>? get contacts => _contacts;

  void populeContacts(List<Contact>? contacts) async {
    _contacts = [];

    if (contacts == null) return;

    for (var contact in contacts) {
      _contacts!.add(contact);
    }
    notifyListeners();
  }

  Future loadContacts() async {
    _contactService.fetchContacts()!.then((results) {
      populeContacts(results);
    });
  }

  Future removeContact(Contact contact) {
    return _contactService.removeContact(contact: contact)!.then((results) {
      loadContactPreviews();
      return results;
    });
  }

  Future udpdateContact(Contact contact) {
    return _contactService.updateContact(contact: contact)!.then((results) {
      loadContactPreviews();
      return results;
    });
  }

  Future register(Contact contact) {
    return _contactService.registerContact(contact: contact)!.then((results) {
      loadContactPreviews();
      return results;
    });
  }

  void loadContactPreviews() async {
    List<Contact>? contacts = await _contactService.fetchContacts()!.then((results) {
      return results;
    });

    contacts ??= [];
    _contactPreviews = [];

    for (Contact contact in contacts) {
      _contactPreviews!.add(
        ContactPreview(
          contact: contact
        )
      );
    }

    notifyListeners();
  }

  Future generateUsers() async {
    _contactService.generateContacts()!.then((results) {
      if (results == true) {
        loadContactPreviews();
      }
    });
  }
}