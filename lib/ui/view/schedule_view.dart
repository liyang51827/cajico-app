import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/view/schedule_detail_view.dart';
import 'package:flutter/material.dart';
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
            headerDateFormat: 'yyyy年M月',
            timeSlotViewSettings: const TimeSlotViewSettings(
              timeIntervalHeight: 80,
              timeFormat: 'HH:mm',
            ),
            dataSource: _getCalendarDataSource(),
            onTap: (CalendarTapDetails details) {
              if (details.appointments != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ScheduleDetailView(selectedAppointment: details.appointments![0]),
                    fullscreenDialog: true,
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}

List<Appointment> _getAppointments(DateTime date) {
  List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
      startTime: DateTime(date.year, date.month, date.day, 10, 0, 0),
      endTime: DateTime(date.year, date.month, date.day, 10, 15, 0),
      subject: '家事１',
      color: primaryColor.withOpacity(0.5)));
  appointments.add(Appointment(
      startTime: DateTime(date.year, date.month, date.day, 11, 0, 0),
      endTime: DateTime(date.year, date.month, date.day, 11, 30, 0),
      subject: '家事２',
      color: primaryColor));
  appointments.add(Appointment(
      startTime: DateTime(date.year, date.month, date.day, 12, 0, 0),
      endTime: DateTime(date.year, date.month, date.day, 12, 45, 0),
      subject: '家事２',
      color: primaryColor.withOpacity(0.5)));
  return appointments;
}

_DataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  DateTime today = DateTime.now();
  DateTime rangeStartDate = DateTime(today.year, today.month, today.day - 7, 0, 0, 0);
  DateTime rangeEndDate = DateTime(today.year, today.month, today.day + 7, 0, 0, 0);
  for (DateTime i = rangeStartDate; i.isBefore(rangeEndDate); i = i.add(Duration(days: 1))) {
    List<Appointment> dailyAppointments = _getAppointments(i);
    appointments.addAll(dailyAppointments);
  }

  return _DataSource(appointments);
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
