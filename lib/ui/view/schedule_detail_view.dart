import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/controller/schedule_detail_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import '../widget/loading_stack.dart';
import '../widget/primary_button.dart';

class ScheduleDetailView extends StatelessWidget {
  const ScheduleDetailView({
    super.key,
    required this.scheduleId,
    required this.date,
  });

  final int scheduleId;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    Get.replace(ScheduleDetailViewController(scheduleId: scheduleId, date: date));
    return Obx(() {
      final controller = Get.put(ScheduleDetailViewController(scheduleId: scheduleId, date: date));
      final appoint = controller.appoint();

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: appoint != null ? appoint.color : Colors.white,
          titleTextStyle: const TextStyle(fontSize: 22),
          elevation: 0.0,
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, size: 24, color: Colors.white),
                ))
          ],
        ),
        body: GetLoadingStack<ScheduleDetailViewController>(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(24),
            child: appoint != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appoint.houseWorkName,
                        style: const TextStyle(fontSize: 20),
                      ),
                      verticalSpaceLarge,
                      _Menu(
                        menu: '時間',
                        value:
                            '${DateFormat('M月d日(E)', 'ja_JP').format(appoint.startTime)}${DateFormat.Hm().format(appoint.startTime)}~${DateFormat.Hm().format(appoint.endTime)}',
                        icon: LineIcons.clock,
                        isPadding: false,
                      ),
                      appoint.displayRepeatRule != null
                          ? _Menu(value: appoint.displayRepeatRule, isPadding: appoint.repeatEndDate != null ? false : true)
                          : verticalSpaceMedium,
                      appoint.repeatEndDate != null
                          ? _Menu(value: '${DateFormat('yyyy年M月d日', 'ja_JP').format(appoint.repeatEndDate!)}まで', isPadding: true)
                          : SizedBox(),
                      _Menu(
                          menu: '状況',
                          value: appoint.status,
                          icon: LineIcons.checkSquare,
                          isPadding: true),
                      appoint.completedUser != null
                          ? _Menu(
                              menu: '完了者',
                              value: appoint.completedUser,
                              icon: LineIcons.user,
                              isPadding: true)
                          : const SizedBox(),
                      _Menu(
                          menu: 'ポイント',
                          value: '${appoint.point}P',
                          icon: LineIcons.coins,
                          isPadding: true),
                    ],
                  )
                : const SizedBox(),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(24),
          child: PrimaryButton(
            label: '完了する',
            onPressed: () {},
            color: appoint != null ? appoint.color : Colors.white,
          ),
        ),
      );
    });
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
