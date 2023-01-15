import 'package:cajico_app/model/house_works.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/top_view.dart';
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
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString('token') != null) {
        await Future.wait([
              () async {
            houseWorks.value = await api.getRecentHouseWorksList();
          }(),
              () async {
            unreadCount.value = await api.getNotificationUnreadCount();
          }(),
        ]);
      } else {
        Get.to(() => const TopView());
      }
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

  Future<void> onTapGetUnreadCount() async {
    await callAsyncApi(() async {
      unreadCount.value = await api.getNotificationUnreadCount();
    });
  }
}
