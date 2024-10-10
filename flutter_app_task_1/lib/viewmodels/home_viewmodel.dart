import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_data_report/blocs/fuel_transaction_bloc.dart';
import 'package:flutter_data_report/blocs/fuel_transaction_event.dart';

class HomeViewModel {
  final TransactionBloc bloc;

  HomeViewModel(this.bloc);

  void importTransactions(File file) {
    bloc.add(ImportTransactions(file));
  }

  void getTransactions() {
    bloc.add(GetTransactions());
  }

  String formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  void getTransactionsInTimeRange(TimeOfDay start, TimeOfDay end) {
    final now = DateTime.now();
    final startDateTime =
        DateTime(now.year, now.month, now.day, start.hour, start.minute);
    final endDateTime =
        DateTime(now.year, now.month, now.day, end.hour, end.minute);
    bloc.add(GetTransactionsInTimeRange(startDateTime, endDateTime));
  }

  void getTotalAmountInTimeRange(TimeOfDay start, TimeOfDay end) {
    final now = DateTime.now();
    final startDateTime =
        DateTime(now.year, now.month, now.day, start.hour, start.minute);
    final endDateTime =
        DateTime(now.year, now.month, now.day, end.hour, end.minute);
    String startTimeString = formatTime(startDateTime);
    String endTimeString = formatTime(endDateTime);

    // Gọi bloc để lấy tổng số tiền trong khoảng thời gian
    bloc.add(GetTotalAmountInTimeRange(startTimeString, endTimeString));
  }
}
