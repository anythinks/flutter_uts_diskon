import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class Koneksidatabase {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    await database.execute(
        'CREATE TABLE barang (kode TEXT ,nama TEXT, satuan TEXT, hargabeli INTEGER, hargajual INTEGER, diskon TEXT, golongan TEXT, warna TEXT, berat INTEGER)');
  }
}
