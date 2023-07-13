import 'package:flutter/material.dart';

class CustomPasswordInput extends StatelessWidget {
  const CustomPasswordInput({
    Key? key,
    required this.controller,
    required this.hint,
    required this.onPress,
    this.hide = true,
    this.keyboardType,
    this.confirmPassword,
    this.borderColor = Colors.black54,
    this.validator,
    this.prefixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final VoidCallback onPress;
  final bool hide;
  final TextInputType? keyboardType;
  final String? confirmPassword;
  final Color borderColor;
  final String? Function(String? value)? validator;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hide,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(0)),
          borderSide: BorderSide(color: borderColor, width: 0.7),
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: onPress,
          icon: Icon(hide ? Icons.visibility : Icons.visibility_off),
        ),
        prefixIcon: prefixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(0)),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(0)),
          borderSide: BorderSide(color: borderColor, width: 0.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(0)),
          borderSide: BorderSide(color: borderColor, width: 0.7),
        ),
      ),
    );
  }
}
