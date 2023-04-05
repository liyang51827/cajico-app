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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black54),
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 22),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(selectedAppointment.subject),
            verticalSpaceMedium,
            _DetailText(text: '$formattedStartTime〜$formattedStartTime'),
            _DetailText(text: 'ステータス：未完了'),
            _DetailText(text: '完了者：かつのり'),
            _DetailText(text: 'ポイント：80P'),
          ],
        ),
      ),
    );
  }
}

class _DetailText extends StatelessWidget {
  const _DetailText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(color: gray3, fontSize: 15));
  }
}
