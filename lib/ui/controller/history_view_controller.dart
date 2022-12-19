import 'package:cajico_app/model/point_history.dart';
import 'package:get/get.dart';
import 'base_view_controller.dart';

class HistoryViewController extends BaseViewController {

  final RxList<PointHistory> pointHistories = <PointHistory>[].obs;
  final totalPointHistory = Rxn<TotalPointHistory>();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      await Future.wait([
        () async {
          pointHistories.value = await api.getPointHistoryList();
        }(),
        () async {
          totalPointHistory.value = await api.getTotalPointHistory();
        }(),
      ]);
    });
  }

  Future<void> onTapDelete({required int pointHistoryId}) async {
    await callAsyncApi(() async {
      await api.deletePointHistory(pointHistoryId: pointHistoryId);
    });
  }
}
