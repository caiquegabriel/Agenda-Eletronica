class Telephone {

  int? _id;
  String? _telephone;
  String? _type;
  int? _userId;

  Telephone ({
    int id = 0,
    required String telephone,
    required String type,
    int userId = 0
  }) {
    _id = id;
    _telephone = telephone;
    _type = type;
    _userId = 0;
  }

  String? get telephone => _telephone;

  String? get type => _type;

  int? get userId => _userId;

  int? get id => _id;

}