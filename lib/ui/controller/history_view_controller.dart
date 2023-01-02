import 'package:cajico_app/model/point_history.dart';
import 'package:get/get.dart';
import 'base_view_controller.dart';

class HistoryViewController extends BaseViewController {
  final RxList<PointHistory> pointHistories = <PointHistory>[].obs;
  final RxList<Point> nextPointHistories = <Point>[].obs;
  final userHistories = <Point>[].obs;
  final pointHistory = Rxn<PointHistory>();

  // 全体家事履歴関連の変数
  final totalPointHistory = Rxn<TotalPointHistory>();
  final totalNextPointHistory = Rxn<TotalPointHistory>();
  final RxList<Point> totalPointHistories = <Point>[].obs;
  final RxList<Point> totalNextPointHistories = <Point>[].obs;
  final totalCurrentPage = 1.obs;

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
          totalNextPointHistories.value = [];
          totalCurrentPage.value = 1;
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

  Future<void> onTapNextPage({required int page, required int userId}) async {
    await callAsyncApi(() async {
      nextPointHistories.value = await api.getUserPointHistoryList(userId: userId, page: page + 1);
      pointHistories.firstWhere((element) => element.userId == userId).pointHistories = [
        ...pointHistories.firstWhere((element) => element.userId == userId).pointHistories,
        ...nextPointHistories()
      ];
      pointHistories.firstWhere((element) => element.userId == userId).currentPage = page + 1;
    });
  }

  Future<void> onTapNextTotalPage({required int page}) async {
    await callAsyncApi(() async {
      totalNextPointHistory.value = await api.getTotalPointHistory(page: page + 1);
      totalNextPointHistories.value = totalNextPointHistory()?.pointHistories ?? [];
      totalPointHistories.value = [...totalPointHistories(), ...totalNextPointHistories()];
      totalCurrentPage.value = totalNextPointHistory()?.currentPage ?? 1;
    });
  }
}
