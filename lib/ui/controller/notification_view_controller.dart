import 'package:get/get.dart';
import '../../model/notice.dart';
import '../../model/pagination_response.dart';
import 'base_view_controller.dart';

class NotificationViewController extends BaseViewController {
  NotificationViewController();

  final paginate = Rxn<PaginationMeta>();
  final RxList<Notice> notices = <Notice>[].obs;
  final adminPaginate = Rxn<PaginationMeta>();
  final RxList<AdminNotice> adminNotices = <AdminNotice>[].obs;

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
      final adminNoticeApi = await api.getAdminNoticesList();
      adminPaginate.value = adminNoticeApi.meta;
      adminNotices.value = adminNoticeApi.data;
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

  Future<void> onTapNextPageAdmin({required int page}) async {
    await callAsyncApi(() async {
      final nextAdminNoticeApi = await api.getAdminNoticesList(page: page);
      final RxList<AdminNotice> nextAdminNotices = <AdminNotice>[].obs;
      nextAdminNotices.value = nextAdminNoticeApi.data;
      adminNotices.value = [...adminNotices(), ...nextAdminNotices()];
      adminPaginate.value = nextAdminNoticeApi.meta;
    });
  }
}
