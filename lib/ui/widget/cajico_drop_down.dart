import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';

import '../common/ui_helper.dart';

class CajicoDropDown<T> extends StatelessWidget {
  const CajicoDropDown({
    super.key,
    required this.items,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.initialValue,
  });

  final String? hintText;

  final String? labelText;

  final List<DropdownMenuItem<T>> items;

  final ValueChanged<T?>? onChanged;

  final T? initialValue;

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<T>(
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 24),
        items: items,
        onChanged: onChanged,
        decoration: defaultInputDecoration(labelText: labelText, hintText: hintText),
        isExpanded: true,
        value: initialValue,
      );
}

class LabelDropDown<T> extends StatelessWidget {
  const LabelDropDown({
    super.key,
    required this.items,
    required this.labelText,
    this.onChanged,
    this.initialValue,
  });

  final String labelText;

  final List<DropdownMenuItem<T>> items;

  final ValueChanged<T?>? onChanged;

  final T? initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: outlineColor, width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            labelText,
            style: const TextStyle(color: textFormLabelColor),
          ),
          DropdownButtonFormField(
            items: items,
            value: initialValue,
            onChanged: onChanged,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.only(
                top: 8,
                bottom: 10,
              ),
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
