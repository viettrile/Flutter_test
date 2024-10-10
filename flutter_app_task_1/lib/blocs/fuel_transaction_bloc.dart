import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/fuel_transaction_repository.dart';
import 'fuel_transaction_event.dart';
import 'fuel_transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final FuelTransactionRepository repository;

  TransactionBloc(this.repository) : super(TransactionInitial()) {
    on<ImportTransactions>(_onImportTransactions);
    on<GetTransactions>(_onGetTransactions);
    on<GetTransactionsInTimeRange>(_onGetTransactionsInTimeRange);
    on<GetTotalAmountInTimeRange>(_onGetTotalAmountInTimeRange);
    on<DeleteFileEvent>(_onDeleteFile);
  }

  void _onImportTransactions(
      ImportTransactions event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    try {
      await for (final count
          in repository.importTransactionsFromExcel(event.file)) {
        emit(ImportProgress(count));
      }
      final transactions = await repository.getTransactions();
      emit(TransactionsLoaded(transactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  void _onGetTransactions(
      GetTransactions event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    try {
      final transactions = await repository.getTransactions();
      emit(TransactionsLoaded(transactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  void _onGetTransactionsInTimeRange(
      GetTransactionsInTimeRange event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    try {
      final transactions =
          await repository.getTransactionsInTimeRange(event.start, event.end);
      emit(TransactionsLoaded(transactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  void _onGetTotalAmountInTimeRange(
      GetTotalAmountInTimeRange event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    try {
      final totalAmount = await repository.getTotalAmountInTimeRange(
          event.startTime, event.endTime);
      emit(TotalAmountLoaded(totalAmount));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }


  void _onDeleteFile(
      DeleteFileEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    try {
      await repository.deleteAllTransactions(); // Xóa dữ liệu trong SQLite
      emit(FileDeleted()); // Trạng thái xóa thành công
    } catch (e) {
      emit(TransactionError('Error deleting transactions: ${e.toString()}'));
    }
  }
}
