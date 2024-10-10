import '../models/transaction.dart';
import '../services/database_service.dart';
import '../services/excel_service.dart';
import 'dart:io';
import 'dart:async';

class FuelTransactionRepository {
  final DatabaseService _databaseService = DatabaseService();
  final ExcelService _excelService = ExcelService();

  Stream<int> importTransactionsFromExcel(File file) async* {
    int count = 0;
    await for (var transaction in _excelService.readExcelFile(file)) {
      await _databaseService.insertTransaction(transaction);
      count++;
      if (count % 100 == 0) {
        yield count;
      }
    }
    yield count;
  }

  Future<List<FuelTransaction>> getTransactions() async {
    return await _databaseService.getTransactions();
  }

  Future<List<FuelTransaction>> getTransactionsInTimeRange(
      DateTime start, DateTime end) async {
    return await _databaseService.getTransactionsInTimeRange(start, end);
  }

  Future<double> getTotalAmountInTimeRange(
      String startTime, String endTime) async {
    final db = await _databaseService
        .database; // Sử dụng _databaseService để lấy cơ sở dữ liệu
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT SUM(totalPrice) as totalAmount FROM transactions WHERE time BETWEEN ? AND ?',
      [startTime, endTime],
    );

    return maps.isNotEmpty && maps.first['totalAmount'] != null
        ? maps.first['totalAmount'] as double
        : 0.0;
  }

  Future<void> deleteAllTransactions() async {
    await _databaseService.deleteAllTransactions();
  }
}
