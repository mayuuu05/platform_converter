import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper dbHelper = DbHelper._();

  DbHelper._();

  Database? _db;

  Future<Database?> get database async => _db ?? await initDatabase();

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'converter.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''
        CREATE TABLE converter(
	      id INTEGER PRIMARY KEY AUTOINCREMENT,
	      img TEXT,
	      time TEXT,
	      date TEXT,
	      bio TEXT,
	      call TEXT,
        name	TEXT
      );
        ''';
        await db.execute(sql);
      },
    );
    return _db!;
  }

  Future<void> insertData(String img, String time, String date, String bio,
      String call, String name) async {
    Database? db = await database;
    String sql = '''
    INSERT INTO converter(img,time,date,bio,call,name) VALUES(?,?,?,?,?,?);
    ''';
    List<dynamic> args = [img, time, date, bio, call, name];
    await db!.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> readData() async {
    Database? db = await database;
    String sql = '''
    SELECT * FROM converter;
    ''';
    return await db!.rawQuery(sql);
  }

  Future<void> removeData(int id) async {
    Database? db = await database;
    String sql = '''DELETE FROM converter WHERE id = ?''';
    List<dynamic> args = [id];
    await db!.rawDelete(sql, args);
  }

  Future<void> updateData(
      String name, String call, String bio, String img, int id) async {
    Database? db = await database;
    String sql =
        '''UPDATE converter SET name = ?, call = ?, bio = ?, img = ? WHERE id = ?''';
    List args = [name, call, bio, img, id];
    await db!.rawUpdate(sql, args);
  }
}
