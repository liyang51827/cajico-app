import 'package:get/get.dart';
import '../../model/notice.dart';
import '../../model/pagination_response.dart';
import 'base_view_controller.dart';

class NotificationViewController extends BaseViewController {
  NotificationViewController();

  final paginate = Rxn<PaginationMeta>();
  final RxList<Notice> notices = <Notice>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      final noticeApi = await api.getNoticesList();
      paginate.value = noticeApi.meta;
      notices.value = noticeApi.data;
    });
  }

  Future<void> onTapNextPage({required int page}) async {
    await callAsyncApi(() async {
      final nextNoticeApi = await api.getNoticesList(page: page);
      final RxList<Notice> nextNotices = <Notice>[].obs;
      nextNotices.value = nextNoticeApi.data;
      notices.value = [...notices(), ...nextNotices()];
      paginate.value = nextNoticeApi.meta;
    });
  }
}
