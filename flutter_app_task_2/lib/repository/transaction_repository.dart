import 'package:flutter_app_task_2/models/transaction_model.dart';

class TransactionRepository {
  final List<Transaction> _transactions = [];

  Future<void> addTransaction(Transaction transaction) async {
  
    await Future.delayed(const Duration(milliseconds: 500));
    _transactions.add(transaction);
  }

  List<Transaction> getTransactions() {
    return _transactions;
  }
}
