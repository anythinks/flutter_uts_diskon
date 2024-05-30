import 'package:myapp/model/koneksidatabase.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late Koneksidatabase _databaseConnection;

  Repository() {
    _databaseConnection = Koneksidatabase();
  }

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  insertData(String tableName, Map<String, dynamic> barang) async {
    var connection = await database;
    return await connection?.insert(tableName, barang);
  }

  readData(String tableName) async {
    var connection = await database;
    return await connection?.query(tableName);
  }

  readDataById(String tableName, itemId) async {
    var connection = await database;
    return await connection
        ?.query(tableName, where: 'kode=?', whereArgs: [itemId]);
  }

  updateData(String tableName, Map<String, dynamic> barang) async {
    var connection = await database;
    return await connection?.update(tableName, barang,
        where: 'kode=?', whereArgs: [barang['kode']]);
  }

  deleteDataBykode(String tableName, kode) async {
    var connection = await database;
    return await connection
        ?.rawDelete("delete from $tableName where kode='$kode'");
  }
}
