import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/notification_view_controller.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.put(NotificationViewController());

      return Scaffold(
        backgroundColor: gray7,
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: const Text('お知らせ', style: TextStyle(color: gray2)),
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(fontSize: 22)),
        body: GetLoadingStack<NotificationViewController>(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.notices().length,
                  itemBuilder: (context, index) {
                    final item = controller.notices.elementAt(index);
                    return _NotificationDetail(date: item.date, message: item.message);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _NotificationDetail extends StatelessWidget {
  const _NotificationDetail({
    required this.date,
    required this.message,
  });

  final String date;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: double.infinity,
        decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black12, //枠線の色
                width: 1, //枠線の太さ
              ),
            ),
            color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(date),
            verticalSpaceTiny,
            SizedBox(width: double.infinity, child: Text(message))
          ],
        ));
  }
}
