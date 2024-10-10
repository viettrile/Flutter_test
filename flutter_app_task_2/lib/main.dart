import 'package:flutter/material.dart';
import 'package:flutter_app_task_2/bloc/transaction_bloc.dart';
import 'package:flutter_app_task_2/repository/transaction_repository.dart';
import 'package:flutter_app_task_2/screens/transaction_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Giao dịch Cửa hàng Xăng',
      home: BlocProvider(
        create: (context) => TransactionBloc(TransactionRepository()),
        child: const TransactionPage(),
      ),
    );
  }
}
