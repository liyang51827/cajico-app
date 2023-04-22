import 'package:cajico_app/model/schedule_appointment_data.dart';
import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/view/schedule_create_view.dart';
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
    Get.replace(ScheduleViewController());
    final controller = Get.put(ScheduleViewController());
    final calendarController = CalendarController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: Header(
          imageUrl: 'assets/images/logo_schedule.png',
          title: '予定',
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  onPressed: () =>
                      controller.onViewChangedGetSchedule(dateTime: calendarController.displayDate),
                  icon: const Icon(Icons.sync, size: 30),
                )),
          ],
        ),
      ),
      drawer: const HomeDrawer(),
      body: GetLoadingStack<ScheduleViewController>(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height:
                MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight,
            child: _Calendar(calendarController: calendarController),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => ScheduleCreateView(
              selectedDate: controller.selectedDateTime() ?? calendarController.displayDate,
            )),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}

class _Calendar extends StatelessWidget {
  const _Calendar({required this.calendarController});
  final calendarController;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScheduleViewController());
    return Obx(() => SfCalendar(
          allowedViews: const [CalendarView.day, CalendarView.week],
          allowViewNavigation: true,
          showDatePickerButton: true,
          view: controller.calendarType() == 0 ? CalendarView.day : CalendarView.week,
          firstDayOfWeek: 1,
          controller: calendarController,
          headerDateFormat: 'yyyy年M月',
          timeSlotViewSettings:
              const TimeSlotViewSettings(timeIntervalHeight: 40, timeFormat: 'H:mm'),
          dataSource: _DataSource(controller.appoints()),
          appointmentBuilder: (BuildContext context, CalendarAppointmentDetails details) {
            return _CalendarAppointmentDetail(details: details, type: controller.calendarType());
          },
          onTap: (CalendarTapDetails details) {
            if (details.appointments != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ScheduleDetailView(
                    scheduleId: details.appointments![0].id,
                    date: details.appointments![0].startTime,
                  ),
                  fullscreenDialog: true,
                ),
              );
            } else {
              controller.selectedDateTime.value = details.date!;
            }
          },
          onViewChanged: (ViewChangedDetails details) {
            if (calendarController.view == CalendarView.day) {
              controller.onViewChangedCalenderType(type: 0);
            } else if (calendarController.view == CalendarView.week) {
              controller.onViewChangedCalenderType(type: 1);
            }
            controller.onViewChangedGetSchedule(dateTime: calendarController.displayDate);
          },
        ));
  }
}

class _CalendarAppointmentDetail extends StatelessWidget {
  const _CalendarAppointmentDetail({required this.details, required this.type});

  final CalendarAppointmentDetails details;
  final int type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: details.appointments.first.location == '未完了'
            ? details.appointments.first.color
            : details.appointments.first.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: type == 0 ? 8 : 1),
        child: Row(
          children: [
            DateTime.now().compareTo(details.appointments.first.endTime) >= 0 &&
                    details.appointments.first.location == '未完了' &&
                    type == 0
                ? const Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Icon(Icons.warning, color: Colors.white, size: 16),
                  )
                : const SizedBox(),
            Expanded(
              child: Text(
                details.appointments.first.subject!,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 11,
                  color: details.appointments.first.location == '未完了' ? Colors.white : gray3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<ScheduleAppointmentSummary> source) {
    // Appointment型のリストを直接セットする
    appointments = <Appointment>[];
    for (var scheduleAppointmentSummary in source) {
      appointments?.add(
        Appointment(
          id: scheduleAppointmentSummary.scheduleId,
          startTime: scheduleAppointmentSummary.startTime,
          endTime: scheduleAppointmentSummary.endTime,
          subject: scheduleAppointmentSummary.subject,
          color: scheduleAppointmentSummary.color,
          location: scheduleAppointmentSummary.status,
        ),
      );
    }
  }
}
