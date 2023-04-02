import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import '../widget/background.dart';
import '../widget/footer.dart';
import '../widget/header.dart';
import '../widget/home_drawer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: Header(
          imageUrl: 'assets/images/logo_schedule.png',
          title: 'スケジュール',
        ),
      ),
      drawer: const HomeDrawer(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height - 143,
          child: SfCalendar(
            view: CalendarView.day,
            timeSlotViewSettings: const TimeSlotViewSettings(
              timeIntervalHeight: 80,
              timeFormat: 'HH:mm',
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
