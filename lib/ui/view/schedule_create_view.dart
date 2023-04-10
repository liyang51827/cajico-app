import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../common/ui_helper.dart';
import '../controller/schedule_view_controller.dart';
import '../widget/cajico_drop_down.dart';
import '../widget/date_picker_form.dart';
import '../widget/time_picker_form.dart';
import '../widget/primary_button.dart';

const List<String> intervals = <String>['1', '2', '3'];

class ScheduleCreateView extends StatelessWidget {
  ScheduleCreateView({
    super.key,
    required this.selectedDate,
  });

  final focusNode = FocusNode();
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final controller = Get.put(ScheduleViewController());
    final scheduleInfo = controller.scheduleCreateData;
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');

    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: const Text('予定の登録', style: TextStyle(color: gray2)),
            backgroundColor: secondaryColor,
            titleTextStyle: const TextStyle(fontSize: 22),
          ),
          body: GetLoadingStack<ScheduleViewController>(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  verticalSpaceLarge,
                  DatePickerForm(
                    labelText: '日付',
                    firstDate: DateTime(today.year - 1, today.month, today.day),
                    lastDate: DateTime(today.year + 1, today.month, today.day),
                    onChange: (value) => scheduleInfo.date.value = outputFormat.format(value!),
                    initialDate: selectedDate!,
                    showInitialDate: true,
                  ),
                  verticalSpaceMedium,
                  TimePickerForm(
                    labelText: '開始時間',
                    onChange: (value) => scheduleInfo.date.value =
                        DateFormat.Hm().format(DateTime(2023, 4, 10, value!.hour, value.minute)),
                    initialTime: TimeOfDay.fromDateTime(today),
                    showInitialDate: true,
                  ),
                  verticalSpaceMedium,
                  TimePickerForm(
                    labelText: '終了時間',
                    onChange: (value) => scheduleInfo.date.value =
                        DateFormat.Hm().format(DateTime(2023, 4, 10, value!.hour, value.minute)),
                    initialTime: TimeOfDay.fromDateTime(today.add(const Duration(minutes: 10))),
                    showInitialDate: true,
                  ),
                  verticalSpaceMedium,
                  CajicoDropDown(
                    onChanged: (value) => scheduleInfo.repeatRule.value = value!,
                    items: const [
                      DropdownMenuItem(value: 999, child: Text('繰り返さない')),
                      DropdownMenuItem(value: 0, child: Text('日')),
                      DropdownMenuItem(value: 1, child: Text('週')),
                      DropdownMenuItem(value: 2, child: Text('月')),
                    ],
                    labelText: '繰り返し',
                  ),
                  verticalSpaceMedium,
                  CajicoDropDown(
                    onChanged: (value) => scheduleInfo.repeatInterval.value = value!,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('1')),
                      DropdownMenuItem(value: 2, child: Text('2')),
                      DropdownMenuItem(value: 3, child: Text('3')),
                    ],
                    labelText: '間隔',
                  ),
                  verticalSpaceMedium,
                  DatePickerForm(
                    labelText: '繰り返し終了日',
                    initialDate: DateTime(today.year, today.month, today.day),
                    firstDate: DateTime(today.year, today.month, today.day),
                    lastDate: DateTime(today.year + 1, today.month, today.day),
                    onChange: (value) =>
                        scheduleInfo.repeatEndDate.value = outputFormat.format(value!),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24),
            child: PrimaryButton(
              label: '登録する',
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
