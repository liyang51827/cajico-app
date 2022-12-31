import 'package:get/get.dart';
import '../../model/notice.dart';
import 'base_view_controller.dart';

class NotificationViewController extends BaseViewController {
  NotificationViewController();

  final RxList<Notice> notices = <Notice>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      notices.value = await api.getNoticesList();
    });
  }
}
