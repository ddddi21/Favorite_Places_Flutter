import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBManager {
  static const _databaseName = "places.db";
  static const _databaseVersion = 2;

  DBManager._privateConstructor();
  static final DBManager instance = DBManager._privateConstructor();


  static Database _database;

  static Future<Database> database() async {
    if (_database != null) return _database;
    final dbPath =
        await getDatabasesPath(); //path of the database in the hard drive
    _database =
        await openDatabase(path.join(dbPath, _databaseName), //open the database
            onCreate: _onCreate,
            version: _databaseVersion);
    return _database;
  }

  // SQL code to create the database table
  static Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE user_places('
        'id TEXT PRIMARY KEY,'
        ' title TEXT, '
        'image TEXT, '
        'loc_lat REAL, '
        'loc_lng REAL, '
        'address TEXT)'); //REAL is basically a double datatype for SQL
    await db.execute('''
          CREATE TABLE user_info (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            surname TEXT
          )
          ''');
  }

   static Future<void> insert(String table, Map<String, Object> data) async {
    print("          $data              ");
    final db = await database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    ); //helps insert a map of [values] into the specified [table]
  }

  static Future<void> update(String table, Map<String, Object> data) async {
    print("          $data              ");
    final db = await database();
    db.update(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    ); //helps insert a map of [values] into the specified [table]
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await database();
    return db.query(table);
  }
}
