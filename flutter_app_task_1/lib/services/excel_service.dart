import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'dart:async';

class ExcelService {
  Stream<FuelTransaction> readExcelFile(File file) async* {
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows.skip(8)) {
        if (row.length >= 17) {
          var transaction = FuelTransaction(
          
            date: DateTime.parse(
                row[1]?.value?.toString() ?? ""), 
            time: row[2]?.value?.toString() ?? "", 
            station: row[3]?.value?.toString() ?? "", 
            pump: row[4]?.value?.toString() ?? "", 
            product: row[5]?.value?.toString() ?? "", 
            quantity: double.parse(
                row[6]?.value?.toString() ?? "0"), 
            unitPrice: double.parse(
                row[7]?.value?.toString() ?? "0"), 
            totalPrice: double.parse(
                row[8]?.value?.toString() ?? "0"), 
            paymentStatus:
                row[9]?.value?.toString() ?? "", 
            customerCode:
                row[10]?.value?.toString() ?? "", 
            customerName:
                row[11]?.value?.toString() ?? "", 
            customerType:
                row[12]?.value?.toString() ?? "", 
            paymentDate: row[13]?.value?.toString() ?? "", 
            employee: row[14]?.value?.toString() ?? "", 
            licensePlate:
                row[15]?.value?.toString() ?? "", 
            invoiceStatus:
                row[16]?.value?.toString() ?? "", 
          );

          // Print out the data that has been read
          debugPrint('Read transaction: ${transaction.toString()}');
           

          yield transaction;
        }
        
      }
    }
  }
}
