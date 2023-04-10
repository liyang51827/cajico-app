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
    this.fontSize = 16,
  });

  final TimeOfDay initialTime;
  final String? hintText;
  final String? labelText;
  final FormFieldSetter<TimeOfDay>? onChange;
  final TextEditingController _controller = TextEditingController();
  final double fontSize;

  @override
  Widget build(BuildContext context) {
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
      applyDateText(picked);
    }
  }

  void applyDateText(TimeOfDay time) {
    _controller.text = DateFormat.Hm().format(DateTime(2023, 4, 10, time.hour, time.minute));
  }
}
