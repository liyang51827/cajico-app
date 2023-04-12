import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../common/ui_helper.dart';

class TimePickerForm extends StatelessWidget {
  TimePickerForm({
    required this.initialTime,
    super.key,
    this.hintText,
    this.labelText,
    this.onChange,
    this.showInitialDate = false,
    this.fontSize = 16,
    this.validator,
  });

  final TimeOfDay initialTime;
  final String? hintText;
  final String? labelText;
  final FormFieldSetter<TimeOfDay>? onChange;
  final TextEditingController _controller = TextEditingController();
  final double fontSize;
  final bool showInitialDate;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    if (showInitialDate) {
      applyDateText(initialTime);
    }
    return GestureDetector(
      onTap: () => _selectDate(),
      child: AbsorbPointer(
        child: TextFormField(
          controller: _controller,
          style: TextStyle(fontSize: fontSize),
          decoration: defaultInputDecoration(
            hintText: hintText,
            labelText: labelText,
            suffixIcon: const Icon(Icons.watch_later_outlined),
          ),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showTimePicker(
      context: Get.context!,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Get.theme.copyWith(
            colorScheme: ColorScheme.light(
              primary: Get.theme.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Get.theme.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onChange?.call(picked);
      validator?.call(DateFormat.Hm().format(DateTime(2023, 4, 10, picked.hour, picked.minute)));
      applyDateText(picked);
    }
  }

  void applyDateText(TimeOfDay time) {
    _controller.text = DateFormat.Hm().format(DateTime(2023, 4, 10, time.hour, time.minute));
  }
}
