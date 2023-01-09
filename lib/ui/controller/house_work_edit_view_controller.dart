import 'base_view_controller.dart';

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

  Future<void> onTapCreate({
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
