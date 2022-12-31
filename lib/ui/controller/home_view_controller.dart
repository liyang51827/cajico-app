import 'package:cajico_app/model/house_works.dart';
import 'package:get/get.dart';
import 'base_view_controller.dart';

class HomeViewController extends BaseViewController {
  final RxList<HouseWork> houseWorks = <HouseWork>[].obs;
  final unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      await Future.wait([
        () async {
          houseWorks.value = await api.getRecentHouseWorksList();
        }(),
        () async {
          unreadCount.value = await api.getNotificationUnreadCount();
        }(),
      ]);
    });
  }

  Future<void> onTapComplete({required int houseWorkId}) async {
    await callAsyncApi(() async {
      await api.postCompleteHouseWork(houseWorkId: houseWorkId);
    });
  }

  Future<void> onTapRead() async {
    await callAsyncApi(() async {
      await api.readNotices();
      unreadCount.value = 0;
    });
  }
}
