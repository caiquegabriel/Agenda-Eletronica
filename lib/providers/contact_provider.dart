import 'package:agenda_eletronica/components/widget_contact_preview.dart';
import 'package:agenda_eletronica/entities/contact.dart';
import 'package:agenda_eletronica/services/ContactService.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  final ContactService _contactService = ContactService();

  List<Contact>? _contacts;

  List<ContactPreview>? _contactPreviews;

  List<ContactPreview>? get contactPreviews => _contactPreviews;

  void populeContacts(List<Contact>? contacts) async {
    _contacts ??= [];

    if (contacts == null) return;

    for (var contact in contacts) {
      _contacts!.add(contact);
    }
  }

  Future loadContacts() async {
    _contactService.fetchContacts()!.then((results) {
      populeContacts(results);
    });
  }

  void loadContactPreviews() async {
    List<Contact>? contacts = await _contactService.fetchContacts()!.then((results) {
      return results;
    });

    contacts ??= [];
    _contactPreviews ??= [];

    for (Contact contact in contacts) {
      _contactPreviews!.add(
        ContactPreview(
          contact: contact
        )
      );
    }
    notifyListeners();
  }
}