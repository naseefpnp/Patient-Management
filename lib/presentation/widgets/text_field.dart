import 'package:flutter/material.dart';
import 'package:patient_management/core/utils/size_utils.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final int? maxLines;

  const AppTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: TextStyle(
              fontSize: SizeUtils.sp(14),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: SizeUtils.h(8)),
        ],
        SizedBox(
          height: maxLines == 1 ? SizeUtils.h(48) : null,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            readOnly: readOnly,
            onTap: onTap,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: SizeUtils.sp(12),
                color: Colors.grey.shade400,
              ),
              suffixIcon: suffixIcon,
              contentPadding: EdgeInsets.symmetric(
                horizontal: SizeUtils.w(14),
                vertical: SizeUtils.h(12),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SizeUtils.w(8)),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SizeUtils.w(8)),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SizeUtils.w(8)),
                borderSide: const BorderSide(color: Color(0xFF0A7C3A)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
