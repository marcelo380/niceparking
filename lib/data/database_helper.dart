import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

class DatabaseHelper {
  static const _databaseName = "nice_parking.db";
  static const _databaseVersion = 1;

  static const tableEstacionalmento = 'GER_ESTACIONAMENTO';

  //singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    //se nao estiver ok faz o seguinte
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('assets', _databaseName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //savar ou copiar do asset
      await File(path).writeAsBytes(bytes);
    }

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $tableEstacionalmento ("
        "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "NUMERO_VAGA INTEGER,"
        "RESPONSAVEL_VEICULO TEXT,"
        "DATA_ENTRADA TEXT,"
        "DATA_SAIDA TEXT,"
        ")");
  }
}
