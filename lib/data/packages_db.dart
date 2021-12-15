import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AdressDB {
  Database _db; //* variavel de acesso ao banco

  Future<Database> get db async {
    _db = await _initDB();
    return _db;
  }

  _initDB() async {
    //* inicializar o banco
    String databasePath = await getDatabasesPath();
    String path = join(databasePath,
        'dbase.db'); //* nome do arquivo q vai ficar salvo o banco de dados
    print(path);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    String sql =
        'create table endereco (cep varchar(10) primary key, logradouro varchar(200), bairro varchar(200), localidade varchar(200), uf varchar(200), numero int)';
    await db.execute(sql);

    sql =
        'CREATE TABLE conquistas (title VARCHAR(30) PRIMARY KEY, descricao VARCHAR(60), porcentagem DOUBLE)';
    await db.execute(sql);

    sql =
        'create table remedios (title VARCHAR(30) PRIMARY KEY, type VARCHAR(100), dosage VARCHAR(100), initial_time TIME, time VARCHAR(100), next VARCHAR(100), interval INTEGER, duration INTEGER );';
    await db.execute(sql);

    sql =
        "insert into remedios (title, type, dosage, initial_time, time, NEXT, next, duration) values ('Remedio 1', 'Capsula', '120mg', '14:00', '18:00', '22:00', 4, 10);";
    await db.execute(sql);
    sql =
        "insert into conquistas (title, descricao, porcentagem) values ('Resistente', 'Concluiu o uso de um medicamento', 40.0);";
    await db.execute(sql);
    sql =
        "insert into conquistas (title, descricao, porcentagem) values ('Criatura da Noite', 'Tomou um medicamento às 3h da manhã', 13.0);";
    await db.execute(sql);
    sql =
        "insert into endereco (cep, logradouro, bairro, localidade, uf, numero) values ('57311185', 'Samaritana', 'Caititus', 'Arapiraca', 'AL', 118)";
    await db.execute(sql);
  }
}
