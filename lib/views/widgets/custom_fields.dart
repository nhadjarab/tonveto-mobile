import 'package:flutter/material.dart';

import '../../config/theme.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final EdgeInsetsGeometry? padding;
  final int? maxLength;

  final int? minLines;
  final int? maxLines;
  final Color? fillColor;
  final Widget? suffixIcon;
  final String? initialValue;
  final FocusNode? focusNode;

  const CustomTextField(
      {Key? key,
      this.initialValue,
      this.hintText,
      this.labelText,
      this.errorText,
      this.controller,
      this.keyboardType,
      this.validator,
      this.onSaved,
      this.onChanged,
      this.padding,
      this.obscureText,
      this.minLines,
      this.fillColor,
      this.maxLines,
      this.maxLength,
      this.suffixIcon,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      focusNode: focusNode,
      minLines: minLines,
      maxLines: obscureText != null ? 1 : maxLines,
      maxLength: maxLength,
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        errorMaxLines: 3,
        contentPadding: padding,
        hintText: hintText,
        labelText: labelText,
        filled: fillColor != null,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        floatingLabelStyle: const TextStyle(color: AppTheme.mainColor),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.mainColor),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
