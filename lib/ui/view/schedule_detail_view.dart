import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../widget/primary_button.dart';

class ScheduleDetailView extends StatelessWidget {
  const ScheduleDetailView({
    super.key,
    required this.selectedAppointment,
  });

  final Appointment selectedAppointment;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('M月d日(E)', 'ja_JP').format(selectedAppointment.startTime);
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
              value: '$formattedDate $formattedStartTime〜$formattedEndTime',
              icon: LineIcons.clock,
              isPadding: false,
            ),
            const _Menu(value: '毎日', isPadding: true),
            _Menu(menu: '状況', value: selectedAppointment.location, icon: LineIcons.checkSquare, isPadding: true),
            const _Menu(menu: '完了者', value: 'かつのり', icon: LineIcons.user, isPadding: true),
            const _Menu(menu: 'ポイント', value: '80P', icon: LineIcons.coins, isPadding: true),
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
  const _Menu({this.menu, required this.value, this.icon, required this.isPadding});

  final String? menu;
  final String? value;
  final IconData? icon;
  final bool isPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadding ? const EdgeInsets.only(bottom: 16) : EdgeInsets.zero,
      child: Row(
        children: [
          icon != null ? Icon(icon, color: subColor) : Icon(icon, color: Colors.white),
          horizontalSpaceMediumSmall,
          SizedBox(
            width: 70,
            child:
                Text(menu ?? '', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text(
              value ?? '',
              maxLines: 2, // 2行に改行
              overflow: TextOverflow.ellipsis, // テキストがオーバーフローした場合の処理
            ),
          )
        ],
      ),
    );
  }
}
