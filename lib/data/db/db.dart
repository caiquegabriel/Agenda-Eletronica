import 'package:agenda_eletronica/data/db/tables.dart';

///
/// Documentação
/// https://pub.dev/packages/sqflite 
///

class DB extends Tables {

  /// Função para efetuar a conexão ao banco de dados.
  Future connect() async {
    return registerTables();
  }

}