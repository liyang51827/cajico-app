import 'package:cajico_app/model/house_work_data.dart';
import 'package:get/get.dart';
import '../../model/form_validation.dart';
import '../../util/form_validator.dart';
import '../widget/normal_completed_dialog.dart';
import '../widget/normal_dialog.dart';
import 'base_view_controller.dart';
import 'home_view_controller.dart';
import 'house_work_view_controller.dart';

class HouseWorkEditViewController extends BaseViewController {
  HouseWorkEditViewController();

  final houseWorkCreateData = HouseWorkCreateData(
    houseWorkCategoryId: 0.obs,
    houseWorkName: ''.obs,
    point: 0.obs,
  );

  final houseWorkEditData = HouseWorkEditData(
    houseWorkId: 0.obs,
    houseWorkName: ''.obs,
    point: 0.obs,
  );

  FormValidation validateInputEditData({String? value, required maxLength}) =>
      FormValidator.validateEditBasicInfo(value: value, maxLength: maxLength);

  FormValidation validateInputPointData({String? value, required maxLength}) =>
      FormValidator.validateRequirePoint(value: value, maxLength: maxLength);

  bool get isHouseWorkCreateButtonValid =>
      validateInputEditData(value: houseWorkCreateData.houseWorkName(), maxLength: 10).isValid &&
      validateInputPointData(value: houseWorkCreateData.point().toString(), maxLength: 10).isValid;

  bool get isHouseWorkEditButtonValid =>
      validateInputEditData(value: houseWorkEditData.houseWorkName(), maxLength: 10).isValid &&
      validateInputPointData(value: houseWorkEditData.point().toString(), maxLength: 10).isValid;

  Future<void> onTapUpdateDialog({
    required int houseWorkCategoryId,
    required int houseWorkId,
  }) async {
    final homeController = Get.put(HomeViewController());
    final houseWorkController =
        Get.put(HouseWorkViewController(houseWorkCategoryId: houseWorkCategoryId));
    houseWorkEditData.houseWorkId.value = houseWorkId;
    Get.dialog(
      NormalDialog(
        message: '更新しますか？',
        onPressed: () async {
          await api.putHouseWork(houseWorkEditData);
          Get.back();
          Get.dialog(
            NormalCompletedDialog(
              message: '更新されました',
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

  Future<void> onTapCreateDialog({required int houseWorkCategoryId}) async {
    final homeController = Get.put(HomeViewController());
    final houseWorkController =
        Get.put(HouseWorkViewController(houseWorkCategoryId: houseWorkCategoryId));
    houseWorkCreateData.houseWorkCategoryId.value = houseWorkCategoryId;
    Get.dialog(
      NormalDialog(
        message: '登録しますか？',
        onPressed: () async {
          await api.createHouseWork(houseWorkCreateData);
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

  Future<void> onTapDelete({required int houseWorkId}) async {
    await callAsyncApi(() async {
      await api.deleteHouseWork(houseWorkId: houseWorkId);
    });
  }
}
