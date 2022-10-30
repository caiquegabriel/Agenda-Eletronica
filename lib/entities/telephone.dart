class Telephone {

  int? _id;
  String? _telephone;
  String? _type;
  int? _contactId;

  Telephone ({
    int id = 0,
    required String telephone,
    required String type,
    int contactId = 0
  }) {
    _id = id;
    _telephone = telephone;
    _type = type;
    _contactId = 0;
  }

  String? get telephone => _telephone;

  String? get type => _type;

  int? get contactId => _contactId;

  int? get id => _id;

}