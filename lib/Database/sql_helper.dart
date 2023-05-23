import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE transactions (
      id TEXT PRIMARY KEY NOT NULL,
      title TEXT NOT NULL,
      amount REAL NOT NULL,
      date INTEGER NOT NULL,
      color INTEGER NOT NULL
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'transaction.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> AddTransaction(
      String id, String title, double amount, int date, int color) async {
    final db = await SQLHelper.db();
    final data = {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date,
      'color': color
    };
    final rid = await db.insert('transactions', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print('data inserted');
    return rid;
  }

  static Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await SQLHelper.db();
    return db.query('transactions', orderBy: "date DESC");
  }

  static Future<void> deleteTransaction(String id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("transactions", where: "id = ?", whereArgs: [id]);
      print('data deleted');
    } catch (e) {
      debugPrint("somthing went wrong with deleting error :$e ");
    }
  }
}
