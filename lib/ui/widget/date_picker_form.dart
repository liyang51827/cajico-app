import 'package:cajico_app/util/date_time_ext.dart';
import 'package:flutter/material.dart';

import '../common/ui_helper.dart';

class DatePickerForm extends StatelessWidget {
  DatePickerForm({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    super.key,
    this.hintText,
    this.onChange,
    this.showInitialDate = false,
    this.dateFormat = 'yyyy年M月d日',
    this.fontSize = 16,
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  final String? hintText;

  final bool showInitialDate;
  final String dateFormat;
  final double fontSize;

  final FormFieldSetter<DateTime>? onChange;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (showInitialDate) {
      applyDateText(initialDate);
    }
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: _controller,
          style: TextStyle(fontSize: fontSize),
          decoration: defaultInputDecoration(
            hintText: hintText,
            suffixIcon: const Icon(Icons.calendar_today_outlined),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return child!;
      },
    );
    if (picked != null) {
      onChange?.call(picked);
      applyDateText(picked);
    }
  }

  void applyDateText(DateTime date) {
    _controller.text = date.toFormatText(format: dateFormat);
  }
}
