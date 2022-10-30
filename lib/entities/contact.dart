class Contact {

  int? _id;
  String? _firstName;
  String? _secondName;
  String? _email;
  String? _cpf;
  String? _photo;
  Map<int, Map> _telephones = {};

  Contact ({
    required int id,
    required String firstName,
    required String secondName,
    required String email,
    required String cpf,
    String photo = "",
    Map<int, Map> telephones = const {}
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

  Map<int, Map> get telephones => _telephones;

}