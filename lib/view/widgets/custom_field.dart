import 'package:flutter/material.dart';
import 'package:vagrancy_beggars/controllers/utils/app_colors.dart';

class CustomField extends StatelessWidget {
  final bool isPrefixIcon;
  final bool isSuffixIcon;
  final bool isPasswordField;
  final bool isObscured;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? color;
  final String? Function(String?)? validator;
  final String? text;
  final TextEditingController? controller;
  final VoidCallback? onSuffixTap;

  const CustomField({
    super.key,
    this.text,
    this.suffixIcon,
    this.isPrefixIcon = false,
    this.isSuffixIcon = false,
    this.isPasswordField = false,
    this.isObscured = false,
    this.prefixIcon,
    this.color,
    this.validator,
    this.controller,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isPasswordField ? isObscured : false,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: color ?? const Color(0xff140D44),

          prefixIcon: isPrefixIcon ? prefixIcon : null,

          // 👇 FIXED: Suffix icon is now tappable
          suffixIcon: isSuffixIcon
              ? GestureDetector(onTap: onSuffixTap, child: suffixIcon)
              : null,

          contentPadding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.height * 0.02,
          ),

          hintText: text,
          hintStyle: const TextStyle(color: Colors.grey),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size.width * 0.03),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size.width * 0.03),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size.width * 0.03),
            borderSide: const BorderSide(
              color: AppColors.buttonColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
