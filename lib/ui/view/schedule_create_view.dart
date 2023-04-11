import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../common/ui_helper.dart';
import '../controller/schedule_view_controller.dart';
import '../widget/cajico_drop_down.dart';
import '../widget/date_picker_form.dart';
import '../widget/time_picker_form.dart';
import '../widget/primary_button.dart';

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
    Get.replace(ScheduleViewController());
    final controller = Get.put(ScheduleViewController());
    final scheduleInfo = controller.scheduleCreateData;
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    scheduleInfo.date.value = outputFormat.format(selectedDate!);
    scheduleInfo.startTime.value = DateFormat.Hm().format(today);
    scheduleInfo.endTime.value = DateFormat.Hm().format(today.add(const Duration(minutes: 10)));

    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Obx(() => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                centerTitle: true,
                title: const Text('予定の登録', style: TextStyle(color: Colors.white)),
                backgroundColor: Color(int.parse(scheduleInfo.colorCode().replaceAll('#', '0x'))),
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
                        initialDate: DateTime.parse(scheduleInfo.date()),
                        showInitialDate: true,
                      ),
                      verticalSpaceMedium,
                      TimePickerForm(
                        labelText: '開始時間',
                        onChange: (value) {
                          scheduleInfo.startTime.value = DateFormat.Hm()
                              .format(DateTime(2023, 4, 10, value!.hour, value.minute));
                          scheduleInfo.endTime.value = DateFormat.Hm()
                              .format(DateTime(2023, 4, 10, value.hour, value.minute + 10));
                        },
                        initialTime: TimeOfDay(
                            hour: int.parse(scheduleInfo.startTime().split(':')[0]),
                            minute: int.parse(scheduleInfo.startTime().split(':')[1])),
                        showInitialDate: true,
                      ),
                      verticalSpaceMedium,
                      TimePickerForm(
                        labelText: '終了時間',
                        onChange: (value) => scheduleInfo.endTime.value = DateFormat.Hm()
                            .format(DateTime(2023, 4, 10, value!.hour, value.minute)),
                        initialTime: TimeOfDay(
                            hour: int.parse(scheduleInfo.endTime().split(':')[0]),
                            minute: int.parse(scheduleInfo.endTime().split(':')[1])),
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
                      scheduleInfo.repeatRule() != 999
                          ? CajicoDropDown(
                              onChanged: (value) => scheduleInfo.repeatInterval.value = value!,
                              items: const [
                                DropdownMenuItem(value: 1, child: Text('1')),
                                DropdownMenuItem(value: 2, child: Text('2')),
                                DropdownMenuItem(value: 3, child: Text('3')),
                              ],
                              labelText: '間隔',
                            )
                          : const SizedBox(),
                      verticalSpaceMedium,
                      scheduleInfo.repeatRule() != 999
                          ? DatePickerForm(
                              labelText: '繰り返し終了日',
                              initialDate: DateTime(today.year, today.month, today.day),
                              firstDate: DateTime(today.year, today.month, today.day),
                              lastDate: DateTime(today.year + 1, today.month, today.day),
                              onChange: (value) =>
                                  scheduleInfo.repeatEndDate.value = outputFormat.format(value!),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => Get.dialog(
                  AlertDialog(
                      title: const Text('カラーを選択してください',
                          style: TextStyle(
                            fontSize: 13,
                            color: gray2,
                          )),
                      content: BlockPicker(
                        pickerColor:
                            Color(int.parse(scheduleInfo.colorCode().replaceAll('#', '0x'))),
                        onColorChanged: (Color value) {
                          scheduleInfo.colorCode.value =
                              '#${value.value.toRadixString(16).toUpperCase().padLeft(8, '0')}';
                          Get.back();
                        },
                        itemBuilder: _customItemBuilder,
                      )),
                ),
                backgroundColor: Color(int.parse(scheduleInfo.colorCode().replaceAll('#', '0x'))),
                child: const Icon(Icons.palette, color: Colors.white),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(24),
                child: PrimaryButton(
                  label: '登録する',
                  onPressed: () {},
                  color: Color(int.parse(scheduleInfo.colorCode().replaceAll('#', '0x'))),
                ),
              ),
            )),
      ),
    );
  }
}

Widget _customItemBuilder(Color color, bool isCurrentColor, void Function() changeColor) {
  return Container(
    margin: const EdgeInsets.all(7),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: changeColor,
        borderRadius: BorderRadius.circular(50),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 210),
          opacity: isCurrentColor ? 1 : 0,
          child: Icon(Icons.done, color: useWhiteForeground(color) ? Colors.white : Colors.black),
        ),
      ),
    ),
  );
}
