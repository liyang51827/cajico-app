import 'package:cajico_app/model/point_history.dart';
import 'package:get/get.dart';
import 'base_view_controller.dart';

class HistoryViewController extends BaseViewController {
  final RxList<PointHistory> pointHistories = <PointHistory>[].obs;
  final totalPointHistory = Rxn<TotalPointHistory>();
  final totalNextPointHistory = Rxn<TotalPointHistory>();
  final RxList<Point> totalPointHistories = <Point>[].obs;
  final RxList<Point> totalNextPointHistories = <Point>[].obs;

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
          totalPointHistories.value = totalPointHistory()?.pointHistories ?? [];
        }(),
      ]);
    });
  }

  Future<void> onTapDelete({required int pointHistoryId}) async {
    var result = false;
    await callAsyncApi(() async {
      result = await api.deletePointHistory(pointHistoryId: pointHistoryId);
    });
    if (result) {
      fetchData();
    }
  }

  Future<void> onTapNextTotalPage() async {
    await callAsyncApi(() async {
      totalNextPointHistory.value = await api.getTotalPointHistory(page: 2);
      totalNextPointHistories.value = totalNextPointHistory()?.pointHistories ?? [];
      totalPointHistories.value = [...totalPointHistories(), ...totalNextPointHistories()];
    });
  }
}
