import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/controller/my_page_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../widget/cajico_cashed_network_image.dart';
import '../widget/loading_stack.dart';
import '../widget/normal_dialog.dart';
import '../widget/primary_button.dart';
import 'my_page_edit_view.dart';

class ScheduleDetailView extends StatelessWidget {
  const ScheduleDetailView({
    super.key,
    required this.selectedAppointment,
  });

  final Appointment selectedAppointment;

  @override
  Widget build(BuildContext context) {
    String formattedStartTime = DateFormat.Hm().format(selectedAppointment.startTime);
    String formattedEndTime = DateFormat.Hm().format(selectedAppointment.endTime);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black54),
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 22),
        elevation: 0.0,
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit, size: 24),
              ))
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              selectedAppointment.subject,
              style: const TextStyle(fontSize: 20),
            ),
            verticalSpaceMedium,
            _Menu(
                menu: '時間',
                value: '$formattedStartTime〜$formattedEndTime',
                icon: LineIcons.clock),
            _Menu(menu: 'ステータス', value: '未完了', icon: LineIcons.checkSquare),
            _Menu(menu: '完了者', value: 'かつのり', icon: LineIcons.user),
            _Menu(menu: 'ポイント', value: '80P', icon: LineIcons.coins),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        child: PrimaryButton(label: '完了する', onPressed: () {}),
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({required this.menu, required this.value, required this.icon});

  final String menu;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: subColor),
          horizontalSpaceMediumSmall,
          SizedBox(
            width: 80,
            child: Text(menu, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 2, // 2行に改行
              overflow: TextOverflow.ellipsis, // テキストがオーバーフローした場合の処理
            ),
          )
        ],
      ),
    );
  }
}
