import 'package:flutter/material.dart';
import 'package:patient_management/core/utils/size_utils.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBg = const Color(0xFF0A7C3A);
    final defaultText = Colors.white;

    return SizedBox(
      width: double.infinity,
      height: height ?? SizeUtils.h(48),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? defaultBg,
          foregroundColor: textColor ?? defaultText,
          disabledBackgroundColor: (backgroundColor ?? defaultBg).withOpacity(
            0.7,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? SizeUtils.w(8)),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: textColor ?? defaultText,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                label,
                style: TextStyle(
                  fontSize: fontSize ?? SizeUtils.sp(15),
                  fontWeight: fontWeight ?? FontWeight.w600,
                  color: textColor ?? defaultText,
                ),
              ),
      ),
    );
  }
}
