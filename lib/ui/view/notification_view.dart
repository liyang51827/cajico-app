import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/loading_stack.dart';
import 'package:cajico_app/ui/widget/next_page_button.dart';
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
      final paginate = controller.paginate();

      return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: const Text('お知らせ', style: TextStyle(color: gray2)),
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(fontSize: 22),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: TabBar(
                labelColor: primaryColor,
                unselectedLabelColor: gray4,
                indicatorColor: primaryColor,
                indicatorWeight: 4,
                labelStyle: TextStyle(fontSize: 16),
                tabs: <Widget>[
                  Tab(child: Text('行動記録')),
                  Tab(child: Text('運営')),
                ],
              ),
            ),
          ),
          body: GetLoadingStack<NotificationViewController>(
            child: TabBarView(
              children: [
                RefreshIndicator(
                  color: primaryColor,
                  onRefresh: controller.fetchData,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.notices().length,
                          itemBuilder: (context, index) {
                            final item = controller.notices.elementAt(index);
                            return _NotificationDetail(
                                date: item.date, message: item.message, isRead: item.isRead);
                          },
                        ),
                        paginate != null && paginate.hasNextPage()
                            ? NextPageButton(
                                onPressed: () =>
                                    controller.onTapNextPage(page: paginate.getNextPage()),
                                label: '次の20件を表示')
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                RefreshIndicator(
                  color: primaryColor,
                  onRefresh: controller.fetchData,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.adminNotices().length,
                          itemBuilder: (context, index) {
                            final item = controller.adminNotices.elementAt(index);
                            return _AdminNotificationDetail(
                              id: item.id,
                              date: item.date,
                              title: item.title,
                              message: item.message,
                              isRead: item.isRead,
                            );
                          },
                        ),
                        paginate != null && paginate.hasNextPage()
                            ? NextPageButton(
                                onPressed: () =>
                                    controller.onTapNextPage(page: paginate.getNextPage()),
                                label: '次の10件を表示')
                            : const SizedBox(),
                      ],
                    ),
                  ),
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
    required this.isRead,
  });

  final String date;
  final String message;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
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
        children: [
          isRead
              ? Text(date, style: const TextStyle(fontSize: 14))
              : Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          verticalSpaceTiny,
          SizedBox(
            width: double.infinity,
            child: isRead
                ? Text(message, style: const TextStyle(fontSize: 14))
                : Text(
                    message,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
          )
        ],
      ),
    );
  }
}

class _AdminNotificationDetail extends StatelessWidget {
  const _AdminNotificationDetail({
    required this.id,
    required this.date,
    required this.title,
    required this.message,
    required this.isRead,
  });

  final int id;
  final String date;
  final String title;
  final String message;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
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
        children: [
          Text(date, style: const TextStyle(fontSize: 12)),
          verticalSpaceTiny,
          isRead
              ? Text(title, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16))
              : Text(title, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          verticalSpaceTiny,
          SizedBox(
            width: double.infinity,
            child: isRead
                ? Text(
                    message,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  )
                : Text(
                    message,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
          )
        ],
      ),
    );
  }
}
