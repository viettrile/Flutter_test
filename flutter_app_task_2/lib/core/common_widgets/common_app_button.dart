import 'package:flutter/material.dart';
import 'package:flutter_app_task_2/core/theme/app_colors.dart';


class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double widthFactor;
  final double? height;
  final double? fontSize;
  final bool isDisabled;
  final bool isLoading;

  const CommonButton(
      {super.key,
      required this.text,
      this.onPressed,
      required this.backgroundColor,
      required this.textColor,
      required this.widthFactor,
      this.height,
      this.isDisabled = false,
      this.isLoading = false,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Opacity(
      opacity: isDisabled || isLoading ? 0.5 : 1,
      child: Container(
        width: size.width * widthFactor,
        height: height ?? 44,
        decoration: BoxDecoration(
          color: isDisabled ? AppColors.gray60 : backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: isDisabled || isLoading ? null : onPressed,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(textColor),
                      strokeWidth: 2.0,
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize ?? 12,
                      letterSpacing: 1.25,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
