
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import '../models/transaction.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'transactions.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE transactions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT NOT NULL,
          time TEXT NOT NULL,
          station TEXT NOT NULL,
          pump TEXT NOT NULL,
          product TEXT NOT NULL,
          quantity REAL NOT NULL,
          unitPrice REAL NOT NULL,
          totalPrice REAL NOT NULL,
          paymentStatus TEXT NOT NULL,
          customerCode TEXT,
          customerName TEXT,
          customerType TEXT,
          paymentDate TEXT,
          employee TEXT,
          licensePlate TEXT,
          invoiceStatus TEXT
        )
      ''');
    });
  }

 Future<int> insertTransaction(FuelTransaction fuelTransaction) async {
    final db = await database;
    int result = await db.insert('transactions', fuelTransaction.toMap());

    
    debugPrint(
        'Inserted transaction into database: ${fuelTransaction.toString()}');

    return result;
  }

  Future<List<FuelTransaction>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    return List.generate(maps.length, (i) => FuelTransaction.fromMap(maps[i]));
  }

  Future<List<FuelTransaction>> getTransactionsInTimeRange(
      DateTime start, DateTime end) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
    );
    return List.generate(maps.length, (i) => FuelTransaction.fromMap(maps[i]));
  }

  Future<double> getTotalAmountInTimeRange(DateTime start, DateTime end) async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT SUM(totalPrice) as total
      FROM transactions
      WHERE date BETWEEN ? AND ?
    ''', [start.toIso8601String(), end.toIso8601String()]);
    return result.first['total'] as double? ?? 0.0;
  }
  Future<void> deleteAllTransactions() async {
    final db = await database;
    await db.delete('transactions');
  }

}
