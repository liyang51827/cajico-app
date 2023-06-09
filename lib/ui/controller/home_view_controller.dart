import 'package:cajico_app/model/house_works.dart';
import 'package:cajico_app/model/point_history.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/home_view.dart';
import '../view/top_view.dart';
import '../widget/house_work_dialog.dart';
import 'base_view_controller.dart';

class HomeViewController extends BaseViewController {
  final RxList<HouseWork> houseWorks = <HouseWork>[].obs;
  final unreadCount = 0.obs;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final pointSummery = Rxn<PointSummery>();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString('token') != null) {
        String? token = await _fcm.getToken();
        await Future.wait([
          () async {
            houseWorks.value = await api.getRecentHouseWorksList();
          }(),
          () async {
            unreadCount.value = await api.getNotificationUnreadCount();
          }(),
          () async {
            pointSummery.value = await api.getMyPointSummery();
          }(),
          () async {
            if (token != null) {
              await api.registerDeviceToken(deviceToken: token);
            }
          }(),
        ]);
      } else {
        Get.to(() => const TopView());
      }
    });
  }

  Future<void> onTapCompleteDialog({required int houseWorkId, required int point}) async {
    Get.back();
    await completeApi(houseWorkId: houseWorkId);
    Get.dialog(HouseWorkCompletedDialog(
      point: point,
      onPressed: () {
        Get.back();
        Get.to(() => const HomeView());
      },
    ));
  }

  Future<void> completeApi({required int houseWorkId}) async {
    var result = false;
    await callAsyncApi(() async {
      result = await api.postCompleteHouseWork(houseWorkId: houseWorkId);
    });
    if (result) {
      fetchData();
    }
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
