class FuelTransaction {
  final DateTime date;
  final String time;
  final String station;
  final String pump;
  final String product;
  final double quantity;
  final double unitPrice;
  final double totalPrice;
  final String paymentStatus;
  final String customerCode;
  final String customerName;
  final String customerType;
  final String paymentDate;
  final String employee;
  final String licensePlate;
  final String invoiceStatus;

  FuelTransaction({
    required this.date,
    required this.time,
    required this.station,
    required this.pump,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.paymentStatus,
    required this.customerCode,
    required this.customerName,
    required this.customerType,
    required this.paymentDate,
    required this.employee,
    required this.licensePlate,
    required this.invoiceStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'time': time,
      'station': station,
      'pump': pump,
      'product': product,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'paymentStatus': paymentStatus,
      'customerCode': customerCode,
      'customerName': customerName,
      'customerType': customerType,
      'paymentDate': paymentDate,
      'employee': employee,
      'licensePlate': licensePlate,
      'invoiceStatus': invoiceStatus,
    };
  }

  factory FuelTransaction.fromMap(Map<String, dynamic> map) {
    return FuelTransaction(
      date: DateTime.parse(map['date']),
      time: map['time'],
      station: map['station'],
      pump: map['pump'],
      product: map['product'],
      quantity: map['quantity'],
      unitPrice: map['unitPrice'],
      totalPrice: map['totalPrice'],
      paymentStatus: map['paymentStatus'],
      customerCode: map['customerCode'],
      customerName: map['customerName'],
      customerType: map['customerType'],
      paymentDate: map['paymentDate'],
      employee: map['employee'],
      licensePlate: map['licensePlate'],
      invoiceStatus: map['invoiceStatus'],
    );
  }
}
