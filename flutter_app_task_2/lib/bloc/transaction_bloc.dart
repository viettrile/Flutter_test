import 'package:equatable/equatable.dart';
import 'package:flutter_app_task_2/models/transaction_model.dart';
import 'package:flutter_app_task_2/repository/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repository;

  TransactionBloc(this.repository) : super(const TransactionState()) {
    on<OnAddTransaction>(_onAddTransaction);
  }

  Future<void> _onAddTransaction(
      OnAddTransaction event, Emitter<TransactionState> emit) async {
    emit(state.copyWith(status: TransactionStatus.loading));

    try {
      final transaction = event.params['transaction'] as Transaction;
      await repository.addTransaction(transaction);
      emit(state.copyWith(
          status: TransactionStatus.success, message: 'Giao dịch thành công!'));
    } catch (e) {
      emit(state.copyWith(
          status: TransactionStatus.failure, message: 'Có lỗi xảy ra!'));
    }
  }
}
