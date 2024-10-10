import 'package:flutter/material.dart';
import 'package:flutter_app_task_2/bloc/transaction_bloc.dart';
import 'package:flutter_app_task_2/core/common_widgets/common_app_button.dart';
import 'package:flutter_app_task_2/core/common_widgets/common_textform_field.dart';
import 'package:flutter_app_task_2/core/common_widgets/keyboard_dismisser.dart';
import 'package:flutter_app_task_2/core/theme/app_colors.dart';
import 'package:flutter_app_task_2/models/transaction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _revenueController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  String _selectedPump = '1';
  DateTime _selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nhập giao dịch'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 16, 0),
              child: _buildUpdateButton(),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 52),
                  _buildDateTimeField(),
                  const SizedBox(height: 28),
                  _buildQuantityField(),
                  const SizedBox(height: 28),
                  _buildPumpSelector(),
                  const SizedBox(height: 28),
                  _buildRevenueField(),
                  const SizedBox(height: 28),
                  _buildUnitPriceField(),
                  const SizedBox(height: 28),
                  _buildTransactionState(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeField() {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDateTime,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
          );

          if (pickedTime != null) {
            setState(() {
              _selectedDateTime = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
            });
          }
        }
      },
      child: AbsorbPointer(
        child: CommonTextFormField(
          controller: TextEditingController(
            text: DateFormat('dd/MM/yyyy HH:mm:ss').format(_selectedDateTime),
          ),
          decoration: const InputDecoration(
            labelText: 'Thời gian',
            suffixIcon: Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityField() {
    return CommonTextFormField(
      controller: _quantityController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: 'Số lượng (lít)'),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.numeric(),
        FormBuilderValidators.min(1),
      ]),
    );
  }

  Widget _buildPumpSelector() {
    return DropdownButtonFormField<String>(
      value: _selectedPump.isEmpty
          ? null
          : _selectedPump, // Nếu _selectedPump rỗng, giá trị mặc định là null
      items: [
        DropdownMenuItem<String>(
          value: null,
          child: Text(''),
        ),
        ...List.generate(5, (index) {
          return DropdownMenuItem(
            value: (index + 1).toString(),
            child: Text('Trụ ${index + 1}'),
          );
        }),
      ],
      onChanged: (value) {
        setState(() {
          _selectedPump = value ?? '';
        });
      },
      decoration: InputDecoration(
        labelText: 'Trụ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: AppColors.gray20,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
      isExpanded: true,
    );
  }

  Widget _buildRevenueField() {
    return CommonTextFormField(
      controller: _revenueController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: 'Doanh thu (VNĐ)'),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.numeric(),
      ]),
    );
  }

  Widget _buildUnitPriceField() {
    return CommonTextFormField(
      controller: _unitPriceController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: 'Đơn giá (VNĐ)'),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.numeric(),
      ]),
    );
  }

  Widget _buildUpdateButton() {
    return CommonButton(
      onPressed: _addTransaction,
      text: 'Cập nhật',
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      widthFactor: 0.2,
      isDisabled: false,
    );
  }

  void _addTransaction() {
    if (_formKey.currentState!.saveAndValidate()) {
      final transaction = Transaction(
        time: _selectedDateTime,
        quantity: double.parse(_quantityController.text),
        pump: _selectedPump,
        revenue: double.parse(_revenueController.text),
        unitPrice: double.parse(_unitPriceController.text),
      );

      context
          .read<TransactionBloc>()
          .add(OnAddTransaction(params: {'transaction': transaction}));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng kiểm tra các trường nhập liệu')),
      );
    }
  }

  Widget _buildTransactionState() {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state.status == TransactionStatus.success) {
          return const Center(
              child: Text('Giao dịch đã được cập nhật thành công!'));
        } else if (state.status == TransactionStatus.failure) {
          return Center(child: Text('Có lỗi xảy ra: ${state.message}'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
