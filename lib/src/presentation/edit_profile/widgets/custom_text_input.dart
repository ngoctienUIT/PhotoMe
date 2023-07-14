import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_me/src/core/utils/extension/string_extension.dart';

enum TypeInput { text, email, phone }

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    Key? key,
    this.title,
    this.radius = 5,
    this.suffixIcon,
    this.prefixIcon,
    this.textStyle,
    this.isBorder = true,
    required this.hint,
    this.isEnabled = true,
    this.validator,
    this.maxLines,
    this.onPress,
    this.onChange,
    this.typeInput,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.focusNode,
    this.backgroundColor = Colors.white,
    this.inputFormatters,
    this.colorBorder = Colors.black54,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10),
    this.onFieldSubmitted,
  }) : super(key: key);

  final String? title;
  final double radius;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final bool isBorder;
  final int? maxLines;
  final String hint;
  final bool isEnabled;
  final VoidCallback? onPress;
  final Function(String text)? onChange;
  final List<TypeInput>? typeInput;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final Color backgroundColor;
  final List<TextInputFormatter>? inputFormatters;
  final Color colorBorder;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry contentPadding;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final Function(String text)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onPress,
      style: textStyle,
      enabled: isEnabled,
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusNode,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      readOnly: onPress == null ? false : true,
      maxLines: maxLines,
      onChanged: onChange,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: backgroundColor,
        contentPadding: contentPadding,
        border: !isBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                borderSide: BorderSide(color: colorBorder, width: 0.7),
              ),
        focusedBorder: !isBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                borderSide: BorderSide(color: colorBorder, width: 0.7),
              ),
        disabledBorder: !isBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                borderSide: BorderSide(color: colorBorder, width: 0.7),
              ),
        enabledBorder: !isBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                borderSide: BorderSide(color: colorBorder, width: 0.7),
              ),
      ),
    );
  }

  String? showError(
    BuildContext context,
    String? value,
    String? title,
    List<TypeInput> typeInput,
  ) {
    String? error;
    for (TypeInput input in typeInput) {
      switch (input) {
        case TypeInput.text:
          if (value!.isNotEmpty) {
            return null;
          } else {
            error = "${"please_enter".translate(context)} $title";
          }
          break;
        case TypeInput.email:
          if (value!.isValidEmail()) {
            return null;
          } else if (!value.isValidEmail() && !value.isOnlyNumbers() ||
              value.isEmpty) {
            error = "please_enter_email".translate(context);
          }
          break;
        case TypeInput.phone:
          if (value!.isValidPhone()) {
            return null;
          } else if (!value.isValidPhone() && value.isOnlyNumbers() ||
              value.isEmpty) {
            error = "please_enter_phone_number".translate(context);
          }
          break;
      }
    }
    return error;
  }
}
