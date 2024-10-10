import 'package:flutter/material.dart';

class FileUploadValidator extends StatelessWidget {
  final String? fileName;
  final bool isValid;

  const FileUploadValidator({
    Key? key,
    required this.fileName,
    required this.isValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (fileName == null || fileName!.isEmpty) {
      return const Text(
        'Chưa có file nào được upload.',
        style: TextStyle(color: Colors.red),
      );
    }
    return isValid
        ? const SizedBox.shrink() // Không hiển thị gì nếu hợp lệ
        : const Text(
            'File không hợp lệ. Vui lòng chọn file .xlsx.',
            style: TextStyle(color: Colors.red),
          );
  }
}
