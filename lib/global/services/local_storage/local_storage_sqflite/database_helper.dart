import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:user_attendance/global/services/local_storage/local_storage_sqflite/attandance_table.dart';
import 'package:user_attendance/global/services/local_storage/local_storage_sqflite/users_table.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'app_database.db';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON;');
        },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE ${UsersTable.tableName} (
            ${UsersTable.columnUserId} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${UsersTable.columnUsername} TEXT NOT NULL,
            ${UsersTable.columnMobileNo} TEXT NOT NULL UNIQUE,
            ${UsersTable.columnCreatedDate} TEXT DEFAULT CURRENT_TIMESTAMP
          )
        ''');

        await db.execute('''
          CREATE TABLE ${AttendanceTable.tableName} (
            ${AttendanceTable.columnTaskId} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${AttendanceTable.columnUserId} INTEGER NOT NULL,
            ${AttendanceTable.columnCreatedDate} TEXT DEFAULT CURRENT_TIMESTAMP,
            ${AttendanceTable.columnInTime} TEXT,
            ${AttendanceTable.columnOutTime} TEXT ,
            ${AttendanceTable.columnAbsentDesc} TEXT,
            FOREIGN KEY (${AttendanceTable.columnUserId}) REFERENCES ${UsersTable.tableName} (${UsersTable.columnUserId}) ON DELETE CASCADE
          )
        ''');
      },
    );
  }
}
