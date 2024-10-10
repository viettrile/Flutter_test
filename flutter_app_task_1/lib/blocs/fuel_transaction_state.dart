import 'package:equatable/equatable.dart';
import '../models/transaction.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionsLoaded extends TransactionState {
  final List<FuelTransaction> transactions;

  const TransactionsLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class TotalAmountLoaded extends TransactionState {
  final double totalAmount;

  const TotalAmountLoaded(this.totalAmount);

  @override
  List<Object> get props => [totalAmount];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);

  @override
  List<Object> get props => [message];
}

class FileDeleted extends TransactionState {}

class ImportProgress extends TransactionState {
  final int count;

  const ImportProgress(this.count);

  @override
  List<Object> get props => [count];
}
