import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class ImportTransactions extends TransactionEvent {
  final File file;

  const ImportTransactions(this.file);

  @override
  List<Object> get props => [file];
}
class DeleteFileEvent extends TransactionEvent {}

class GetTransactions extends TransactionEvent {}

class GetTransactionsInTimeRange extends TransactionEvent {
  final DateTime start;
  final DateTime end;

  const GetTransactionsInTimeRange(this.start, this.end);

  @override
  List<Object> get props => [start, end];
}

class GetTotalAmountInTimeRange extends TransactionEvent {
  final String startTime;
  final String endTime;

  GetTotalAmountInTimeRange(this.startTime, this.endTime);
}
