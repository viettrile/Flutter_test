class Transaction {
  final DateTime time;
  final double quantity;
  final String pump;
  final double revenue;
  final double unitPrice;

  Transaction({
    required this.time,
    required this.quantity,
    required this.pump,
    required this.revenue,
    required this.unitPrice,
  });
}
