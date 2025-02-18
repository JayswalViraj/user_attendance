import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:user_attendance/global/services/local_storage/local_storage_sqflite/users_table.dart';
import '../../../models/attandance_model.dart';
import 'database_helper.dart';

class AttendanceTable {
  static const String tableName = "AttendanceTable";

  static const String columnTaskId = "TaskId";
  static const String columnUserId = "UserId";
  static const String columnCreatedDate = "CreatedDate";
  static const String columnInTime = "InTime";
  static const String columnOutTime = "OutTime";
  static const String columnAbsentDesc = "AbsentDesc";

  // Insert a new attendance record
  static Future<int> insertAttendance(
      {required int userId,
      required String createdDate,
       String? inTime,
       String? outTime,
      String? absentDesc}) async {
    final db = await DatabaseHelper.database;
    return await db.insert(
      tableName,
      {
        '$columnUserId': userId,
        '$columnCreatedDate': createdDate,
        '$columnInTime': inTime,
        '$columnOutTime': outTime,
        '$columnAbsentDesc': absentDesc,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fetch all attendance records
  static Future<List<AttendanceModel>> getAllAttendance() async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    debugPrint("maps: " + maps.toString());

    return List.generate(maps.length, (i) {
      return AttendanceModel.fromMap(maps[i]);
    });
  }

  // Fetch attendance by Username
  static Future<List<AttendanceModel>> getAttendanceByUsername(
      String username) async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query(tableName, where: 'Username = ?', whereArgs: [username]);

    return List.generate(maps.length, (i) {
      return AttendanceModel.fromMap(maps[i]);
    });
  }

  // Delete an attendance record
  static Future<int> deleteAttendance(int taskId) async {
    final db = await DatabaseHelper.database;
    return await db
        .delete(tableName, where: '$columnTaskId = ?', whereArgs: [taskId]);
  }

  // Update an attendance record
  static Future<int> updateAttendance(
      {String? inTime,
      String? outTime,
      required int taskId,
      required int userId,String? absentDesc}) async {
    final db = await DatabaseHelper.database;
    return await db.update(
      tableName,
      {
        '$columnUserId': userId,
        '$columnInTime': inTime,
        '$columnOutTime': outTime,
        '$columnAbsentDesc': absentDesc,

      },
      where: '$columnTaskId = ?',
      whereArgs: [taskId],
    );
  }

  static Future<List<AttendanceModel>> getAttendanceWithUsers() async {
    final db = await DatabaseHelper.database;

    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT 
      $tableName.$columnTaskId, 
      $tableName.$columnCreatedDate, 
      $tableName.$columnInTime, 
      $tableName.$columnOutTime, 
      $tableName.$columnUserId, 
      $tableName.$columnAbsentDesc,
      ${UsersTable.tableName}.${UsersTable.columnUsername},  
      ${UsersTable.tableName}.${UsersTable.columnMobileNo}
    FROM $tableName
    INNER JOIN ${UsersTable.tableName} 
      ON $tableName.$columnUserId = ${UsersTable.tableName}.${UsersTable.columnUserId}
    ORDER BY $tableName.$columnCreatedDate DESC
  ''');

    debugPrint("result: " + result.toString());

    return List.generate(result.length, (i) {
      return AttendanceModel.fromMap(result[i]);
    });
  }



  static Future<int> getAttandanceCount() async {
    final db = await DatabaseHelper.database;

    final List<Map<String, dynamic>> result =
    await db.rawQuery('SELECT COUNT(*) as count FROM $tableName');

    return Sqflite.firstIntValue(result) ?? 0;
  }
}
