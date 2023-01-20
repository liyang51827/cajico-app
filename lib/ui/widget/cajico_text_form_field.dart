import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/app_color.dart';

class CajicoTextFormField extends StatelessWidget {
  const CajicoTextFormField({
    super.key,
    required this.initValue,
    required this.label,
    this.maxLines,
    this.minLines,
    this.suffixText,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.readOnly = false,
    this.fillColor,
    this.filled = false,
    this.focusedBorderColor = primaryColor,
    this.onChanged,
    this.obscureText = false,
  });

  final String label;
  final String initValue;
  final String? suffixText;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final Color focusedBorderColor;
  final bool? filled;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController.fromValue(
        TextEditingValue(text: initValue),
      ),
      readOnly: readOnly,
      cursorColor: primaryColor,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      minLines: minLines,
      maxLines: maxLines,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: filled,
        labelText: label,
        suffixText: suffixText,
        labelStyle: const TextStyle(color: gray3),
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: gray4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: focusedBorderColor),
        ),
        errorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: errorColor),
        ),
        focusedErrorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: errorColor),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
