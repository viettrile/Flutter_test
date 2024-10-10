part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  final Map<String, dynamic> params;
  const TransactionEvent({required this.params});

  @override
  List<Object> get props => [params];
}

class OnAddTransaction extends TransactionEvent {
  const OnAddTransaction({required super.params});
}
