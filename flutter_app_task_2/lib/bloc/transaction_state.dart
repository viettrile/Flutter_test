part of 'transaction_bloc.dart';

enum TransactionStatus {
  initial,
  loading,
  success,
  failure,
}

class TransactionState extends Equatable {
  final Transaction? transaction;
  final TransactionStatus status;
  final String? message;

  const TransactionState({
    this.transaction,
    this.status = TransactionStatus.initial,
    this.message,
  });

  TransactionState copyWith({
    Transaction? transaction,
    TransactionStatus? status,
    String? message,
  }) {
    return TransactionState(
      transaction: transaction ?? this.transaction,
      status: status ?? this.status,
      message: message,
    );
  }

  @override
  List<Object?> get props => [transaction, status, message];
}
