import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_wise/features/auth/data/models/user_model.dart';

abstract interface class AuthLocalDatSource {
  Future<void> insertUser(UserModel user);

  Future<UserModel?> getUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDatSource {
  String tableName = "users";
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "auth.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
      CREATE TABLE $tableName(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');
      },
    );
  }

  @override
  Future<void> insertUser(UserModel user) async {
    final db = await database;
    await db.insert(
      tableName,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<UserModel?> getUser() async {
    final db = await database;
    final result = await db.query(tableName, limit: 1);
    if (result.isEmpty) {
      return null;
    }
    return UserModel.fromJson(result.first);
  }
}
