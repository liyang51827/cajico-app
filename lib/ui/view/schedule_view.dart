import 'package:cajico_app/model/schedule_appointment_data.dart';
import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/view/schedule_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/schedule_view_controller.dart';
import '../widget/footer.dart';
import '../widget/header.dart';
import '../widget/home_drawer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../widget/loading_stack.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScheduleViewController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: Header(
          imageUrl: 'assets/images/logo_schedule.png',
          title: '予定',
        ),
      ),
      drawer: const HomeDrawer(),
      body: GetLoadingStack<ScheduleViewController>(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 143,
            child: Obx(() {
              return SfCalendar(
                view: CalendarView.day,
                headerDateFormat: 'yyyy年M月',
                timeSlotViewSettings: const TimeSlotViewSettings(
                  timeIntervalHeight: 100,
                  timeFormat: 'HH:mm',
                ),
                dataSource: _DataSource(controller.appoints()),
                appointmentBuilder: (BuildContext context, CalendarAppointmentDetails details) {
                  return _CalendarAppointmentDetail(details: details);
                },
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
              );
            }),
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

class _DataSource extends CalendarDataSource {
  _DataSource(List<ScheduleAppointment> source) {
    // Appointment型のリストを直接セットする
    appointments = <Appointment>[];
    for (var scheduleAppointment in source) {
      appointments?.add(
        Appointment(
          startTime: scheduleAppointment.startTime,
          endTime: scheduleAppointment.endTime,
          subject: scheduleAppointment.subject,
          color: scheduleAppointment.color,
          notes: scheduleAppointment.userName,
          location: scheduleAppointment.status,
          recurrenceId: scheduleAppointment.point,
          recurrenceRule: scheduleAppointment.repeatRule,
        ),
      );
    }
  }
}

class _CalendarAppointmentDetail extends StatelessWidget {
  const _CalendarAppointmentDetail({required this.details});

  final CalendarAppointmentDetails details;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DateTime.now().compareTo(details.appointments.first.endTime) < 0
            ? details.appointments.first.color
            : details.appointments.first.location == '未完了'
                ? Colors.white
                : details.appointments.first.color.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
        border: DateTime.now().compareTo(details.appointments.first.endTime) >= 0 &&
                details.appointments.first.location == '未完了'
            ? Border.all(color: details.appointments.first.color, width: 2.0)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            DateTime.now().compareTo(details.appointments.first.endTime) >= 0 &&
                    details.appointments.first.location == '未完了'
                ? Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(
                      Icons.warning,
                      color: details.appointments.first.color,
                      size: 16,
                    ),
                  )
                : const SizedBox(),
            Text(
              details.appointments.first.subject!,
              style: TextStyle(
                fontSize: 13,
                color: DateTime.now().compareTo(details.appointments.first.endTime) < 0
                    ? Colors.white
                    : details.appointments.first.location == '未完了'
                        ? details.appointments.first.color
                        : gray3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
