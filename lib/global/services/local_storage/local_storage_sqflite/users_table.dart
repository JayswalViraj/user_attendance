import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import '../../../models/users_model.dart';
import 'database_helper.dart';

class UsersTable {
  static const String tableName = 'UsersTable';
  static const String columnUserId ="UserId";
  static const String columnUsername="Username";
  static const String columnMobileNo="MobileNo";
  static const String columnCreatedDate ="CreatedDate";


  // Insert a new user
  static Future<int> insertUser(UsersModel user) async {
    final db = await DatabaseHelper.database;
    return await db.insert(
      tableName,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fetch all users
// Fetch all users with optional search by username or mobile number, sorted by CreatedDate (descending)
  static Future<List<UsersModel>> getUsers({String? searchText}) async {
    final db = await DatabaseHelper.database;

    // Base query
    String query = 'SELECT * FROM $tableName';
    List<dynamic> args = [];

    // If searchText is provided, filter by username OR mobile number
    if (searchText != null && searchText.isNotEmpty) {
      query += ' WHERE Username LIKE ? OR MobileNo LIKE ?';
      args.add('%$searchText%'); // Partial match for username
      args.add('%$searchText%'); // Partial match for mobile number
    }

    // Append ORDER BY clause to sort by CreatedDate in descending order
    query += ' ORDER BY CreatedDate DESC';

    final List<Map<String, dynamic>> maps = await db.rawQuery(query, args);

    debugPrint("Users List: ${maps.length}");

    return List.generate(maps.length, (i) {
      return UsersModel.fromMap(maps[i]);
    });
  }


  // Delete a user
  static Future<int> deleteUser(int id) async {
    final db = await DatabaseHelper.database;
    return await db.delete(tableName, where: '$columnUserId = ?', whereArgs: [id]);
  }

  // Update a user
  static Future<int> updateUser({required int userId,required String username,required String mobileNo}) async {
    final db = await DatabaseHelper.database;
    return await db.update(
      tableName,
      {
        '$columnUsername': username,
        '$columnMobileNo': mobileNo,
      },
      where: '$columnUserId = ?',
      whereArgs: [userId],
    );
  }

  static Future<int> getUserCount() async {
    final db = await DatabaseHelper.database;

    final List<Map<String, dynamic>> result =
    await db.rawQuery('SELECT COUNT(*) as count FROM $tableName');

    return Sqflite.firstIntValue(result) ?? 0;
  }

}
