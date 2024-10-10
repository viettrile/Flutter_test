import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_data_report/blocs/fuel_transaction_bloc.dart';
import 'package:flutter_data_report/blocs/fuel_transaction_event.dart';
import 'package:flutter_data_report/blocs/fuel_transaction_state.dart';
import 'package:flutter_data_report/widgets/widget_file_upload_validator.dart';
import '../viewmodels/home_viewmodel.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel _viewModel;
  TimeOfDay _startTime =const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _endTime =const TimeOfDay(hour: 23, minute: 59);
  String? _fileName; // Biến lưu tên file
  bool _isFileValid = true; // Biến kiểm tra tính hợp lệ của file

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(BlocProvider.of<TransactionBloc>(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Quản lý giao dịch'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildUploadContainer(),
            Text("Chỉ upload .xlsx file"),
            FileUploadValidator(
              fileName: _fileName,
              isValid: _isFileValid,
            ),
            const SizedBox(height: 20),
            _buildFileCard(),
            const SizedBox(height: 20),
            _buildTimeSelector(
                'Giờ bắt đầu: ${_startTime.format(context)}', true),
            const SizedBox(height: 16),
            _buildTimeSelector(
                'Giờ kết thúc: ${_endTime.format(context)}', false),
            const SizedBox(height: 20),
            Expanded(child: _buildTransactionState()),
            const SizedBox(height: 20),
            _buildCalculateButton(),
          ],
        ),
      ),
    );
  }

  Container _buildUploadContainer() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Color.fromRGBO(226, 248, 226, 1), // Màu xanh nhạt
        border: Border.all(
          color: const Color.fromRGBO(232, 245, 233, 1),
          style: BorderStyle.solid,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.upload_file, size: 40, color: Colors.green),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _importExcel,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text(
                'Chọn file',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _buildFileCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(Icons.description, color: Colors.green),
        title: Text(
          _fileName ?? 'Chưa chọn file',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: _deleteFile,
        ),
      ),
    );
  }

  Widget _buildTimeSelector(String label, bool isStartTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        ElevatedButton(
          onPressed: () => _selectTime(context, isStartTime),
          child: const Text('Select Time'),
        ),
      ],
    );
  }

  Expanded _buildTransactionState() {
    return Expanded(
      child: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionsLoaded) {
            return const Center(child: Text('Đã upload xong, hãy tính tiền!'));
          } else if (state is TotalAmountLoaded) {
            final formattedTotal =
                NumberFormat('#,##0').format(state.totalAmount);
            return Center(
              child: Text('Tổng tiền: $formattedTotal VNĐ',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            );
          } else if (state is TransactionError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ImportProgress) {
            return Center(child: Text('Đã upload ${state.count} giao dịch'));
          }
          return const Center(child: Text('Upload file excel để bắt đầu!'));
        },
      ),
    );
  }

  ElevatedButton _buildCalculateButton() {
    return ElevatedButton(
      onPressed: _fileName != null
          ? () => _viewModel.getTotalAmountInTimeRange(_startTime, _endTime)
          : null, // Không cho phép bấm nếu chưa có file
      style: ElevatedButton.styleFrom(
        backgroundColor:
            _fileName != null ? Colors.green : Colors.grey, // Đổi màu nút
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: const Text(
        'Thành tiền',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  void _deleteFile() {
    BlocProvider.of<TransactionBloc>(context).add(DeleteFileEvent());
    setState(() {
      _fileName = null; // Reset tên file
      _isFileValid = true; // Reset tính hợp lệ
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('File đã được xóa.')),
    );
  }

  void _importExcel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      setState(() {
        _fileName = result.files.single.name; // Lưu tên file để hiển thị
        _isFileValid = true; // Đặt tính hợp lệ
      });
      _viewModel.importTransactions(file);
    } else {
      setState(() {
        _isFileValid = false; // Cập nhật tính hợp lệ nếu không có file
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chưa chọn file hoặc file không hợp lệ.')),
      );
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }
}
