import 'package:get/get.dart';
import '../widget/normal_completed_dialog.dart';
import '../widget/normal_dialog.dart';
import 'base_view_controller.dart';
import 'home_view_controller.dart';
import 'house_work_view_controller.dart';

class HouseWorkEditViewController extends BaseViewController {
  HouseWorkEditViewController();

  Future<void> onTapUpdate({
    required int houseWorkId,
    required String houseWorkName,
    required int point,
  }) async {
    await callAsyncApi(() async {
      await api.putHouseWork(houseWorkId: houseWorkId, houseWorkName: houseWorkName, point: point);
    });
  }

  Future<void> onTapCreateDialog({
    required int houseWorkCategoryId,
    required String houseWorkName,
    required int point,
  }) async {
    final homeController = Get.put(HomeViewController());
    final houseWorkController = Get.put(HouseWorkViewController(houseWorkCategoryId: houseWorkCategoryId));
    Get.dialog(
      NormalDialog(
        message: '登録しますか？',
        onPressed: () async {
          await createApi(
            houseWorkCategoryId: houseWorkCategoryId,
            houseWorkName: houseWorkName,
            point: point,
          );
          Get.back();
          Get.dialog(
            NormalCompletedDialog(
              message: '登録されました',
              onPressed: () {
                Get.back();
                homeController.onTapGetUnreadCount();
                Get.back();
                houseWorkController.fetchData();
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> createApi({
    required int houseWorkCategoryId,
    required String houseWorkName,
    required int point,
  }) async {
    await callAsyncApi(() async {
      await api.createHouseWork(
        houseWorkCategoryId: houseWorkCategoryId,
        houseWorkName: houseWorkName,
        point: point,
      );
    });
  }

  Future<void> onTapDelete({required int houseWorkId}) async {
    await callAsyncApi(() async {
      await api.deleteHouseWork(houseWorkId: houseWorkId);
    });
  }
}
