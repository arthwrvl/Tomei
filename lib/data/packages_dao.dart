import 'package:sqflite/sqflite.dart';
import 'package:tomei/data/packages_db.dart';
import 'package:tomei/model/Achievements.dart';
import 'package:tomei/model/Adress.dart';
import 'package:tomei/model/Remedios.dart';

class PackagesDao {
  final tablName = 'endereco';

  Future<Adress> findAdress() async {
    AdressDB database = AdressDB();
    Database db = await database.db;

    Adress endereco; //*objeto que vou recuperar do banco de dados

    String sql = "select * from $tablName";
    final result = await db.rawQuery(sql);

    endereco = Adress.fromJson(
        result[0]); //*aqui uso o [0] porque considerei que endereco é apenas um
    //*mas se fosse uma lista como o remedio, seria necessário um for

    print(endereco.cidade);
    return endereco;
  }

  deleteAddress(String cep) async {
    AdressDB database = AdressDB();
    Database db = await database.db;
    var id = await db.rawDelete('delete from $tablName where cep = ?', [cep]);
  }

  deleteRemedio(String nome) async {
    AdressDB database = AdressDB();
    Database db = await database.db;
    var id = await db.rawDelete('delete from remedios where title = ?', [nome]);
  }

  addAddress(Adress endereco) async {
    AdressDB database = AdressDB();
    Database db = await database.db;

    var id1 = await db.insert(tablName, endereco.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  addRemedio(Remedio remedio) async {
    AdressDB database = AdressDB();
    Database db = await database.db;

    var id1 = await db.insert('remedios', remedio.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Achievements>> loadAchievents(String tableName) async {
    AdressDB database = AdressDB();
    Database db = await database.db;

    Achievements conquistas;

    String sql = 'SELECT * FROM $tableName';
    final result = await db.rawQuery(sql);

    List<Achievements> listaConquistas = <Achievements>[];
    for (var json in result) {
      listaConquistas.add(Achievements.fromJson(json));
    }
    return listaConquistas;
  }

  Future<List<Remedio>> loadremedios(String tableName) async {
    AdressDB database = AdressDB();
    Database db = await database.db;

    Remedio conquistas;

    String sql = 'SELECT * FROM $tableName';
    final result = await db.rawQuery(sql);

    List<Remedio> listaConquistas = <Remedio>[];
    for (var json in result) {
      listaConquistas.add(Remedio.fromJson(json));
    }
    return listaConquistas;
  }
}
