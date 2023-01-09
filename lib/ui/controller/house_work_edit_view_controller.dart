import 'base_view_controller.dart';

class HouseWorkEditViewController extends BaseViewController {
  HouseWorkEditViewController();

  Future<void> onTapUpdate({
    required int houseWorkId,
    required String houseWorkName,
    required int point,
  }) async {
    await callAsyncApi(() async {
      await api.putHouseWork(
        houseWorkId: houseWorkId,
        houseWorkName: houseWorkName,
        point: point,
      );
    });
  }
}
