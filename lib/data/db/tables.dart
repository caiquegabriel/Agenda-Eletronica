// Tabelas a serem criadas na primeira execução

import 'package:sqflite/sqflite.dart';

import '../../env.dart';

class Tables {

  /// Pegar a localização do arquivo SQLite
  getPath() async {
    var databasesPath = await getDatabasesPath();

    String path = "$databasesPath/$dbName.db";
    
    return path;
  }

  registerTables() async {

    String path = await getPath();

    return await openDatabase(path, version: 1,
      onConfigure: (Database db) async {
        // Tabela do telefone
        await db.execute(
          'CREATE TABLE IF NOT EXISTS telephone (id INTEGER PRIMARY KEY AUTOINCREMENT, telephone TEXT, userId INTEGER, type TEXT)'
        );
        // Tabela do contato
        await db.execute(
          'CREATE TABLE IF NOT EXISTS contact (id INTEGER PRIMARY KEY AUTOINCREMENT, firstName TEXT, secondName TEXT, email TEXT, photo Text, cpf TEXT)'
        );
      },
      onUpgrade: (Database db, int a, int b) async {
        // Tabela do telefone
        await db.execute(
          'CREATE TABLE IF NOT EXISTS telephone (id INTEGER PRIMARY KEY AUTOINCREMENT, telephone TEXT, userId INTEGER, type TEXT)'
        );
        // Tabela do contato
        await db.execute(
          'CREATE TABLE IF NOT EXISTS contact (id INTEGER PRIMARY KEY AUTOINCREMENT, firstName TEXT, secondName TEXT, email TEXT, photo Text, cpf TEXT)'
        );
      },
      onCreate: (Database db, int a) async {
        // Tabela do telefone
        await db.execute(
          'CREATE TABLE IF NOT EXISTS telephone (id INTEGER PRIMARY KEY AUTOINCREMENT, telephone TEXT, userId INTEGER, type TEXT)'
        );
        // Tabela do contato
        await db.execute(
          'CREATE TABLE IF NOT EXISTS contact (id INTEGER PRIMARY KEY AUTOINCREMENT, firstName TEXT, secondName TEXT, email TEXT, photo Text, cpf TEXT)'
        );
      }
    );
  }

  // Função para remover todo o banco de dados
  Future<dynamic> deleteAllDataBase() async{
    String path = await getPath();
    return await deleteDatabase(path);
  }
}