import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/house_work_edit_view_controller.dart';
import '../controller/schedule_view_controller.dart';
import '../widget/cajico_drop_down.dart';
import '../widget/primary_button.dart';

class ScheduleCreateView extends StatelessWidget {
  ScheduleCreateView({super.key});

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScheduleViewController());
    final scheduleInfo = controller.scheduleCreateData;

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
          body: GetLoadingStack<HouseWorkEditViewController>(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Obx(
                () => Column(
                  children: [
                    verticalSpaceLarge,
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
                    scheduleInfo.repeatRule() == 0 || scheduleInfo.repeatRule() == 1
                        ? CajicoDropDown(
                            onChanged: (value) => scheduleInfo.repeatInterval.value = value!,
                            items: const [
                              DropdownMenuItem(value: 1, child: Text('1')),
                              DropdownMenuItem(value: 2, child: Text('2')),
                              DropdownMenuItem(value: 3, child: Text('3')),
                            ],
                            labelText: '間隔',
                          )
                        : scheduleInfo.repeatRule() == 2
                            ? CajicoDropDown(
                                onChanged: (value) => scheduleInfo.repeatInterval.value = value!,
                                items: const [
                                  DropdownMenuItem(value: 1, child: Text('1')),
                                ],
                                labelText: '間隔',
                              )
                            : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24),
            child: Obx(
              () => PrimaryButton(
                label: '登録する',
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
