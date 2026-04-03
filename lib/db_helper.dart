import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'krushi_mitra.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT)",
        );
      },
    );
  }

  // User save karnya sathi
  static Future<int> registerUser(String user, String pass) async {
    final db = await database;
    return await db.insert('users', {'username': user, 'password': pass});
  }

  // Login check karnya sathi
  static Future<bool> loginCheck(String user, String pass) async {
    final db = await database;
    List<Map> result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [user, pass],
    );
    return result.isNotEmpty;
  }
}