import 'package:aim_digital_technologies_test_flutter/utils/svg_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String prefixImage;
  final double prefixIconWidth;
  final double prefixIconHeight;
  final bool obSecureText;
  final String errorText;
  final Function(String) onTextChanged;

  const TextFormFieldWidget({
    super.key,
    this.controller,
    required this.hintText,
    required this.prefixImage,
    required this.prefixIconWidth,
    required this.prefixIconHeight,
    this.obSecureText = false,
    this.errorText = '',
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.white,
      onChanged: onTextChanged,
      obscureText: obSecureText,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        errorText: errorText.isEmpty ? null : errorText,
        prefixIcon: SvgPicture.asset(prefixImage),
        prefix: SizedBox(
          width: 3.w,
        ),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        prefixIconConstraints: BoxConstraints(
          minHeight: prefixIconHeight,
          maxHeight: prefixIconHeight,
          maxWidth: prefixIconWidth,
          minWidth: prefixIconWidth,
        ),
        hintText: hintText,
        contentPadding: EdgeInsets.zero,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}
