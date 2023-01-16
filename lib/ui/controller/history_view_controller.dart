import 'package:cajico_app/model/point_history.dart';
import 'package:get/get.dart';
import '../widget/house_work_history_delete_dialog.dart';
import '../widget/normal_completed_dialog.dart';
import 'base_view_controller.dart';
import 'home_view_controller.dart';

class HistoryViewController extends BaseViewController {
  final RxList<PointHistory> pointHistories = <PointHistory>[].obs;

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
          totalPointHistories.value = totalPointHistory()?.points ?? [];
          totalNextPointHistories.value = [];
          totalCurrentPage.value = 1;
        }(),
      ]);
    });
  }

  Future<void> onTapDeleteDialog({
    required bool isMe,
    required String houseWorkName,
    required String categoryName,
    required int pointHistoryId,
  }) async {
    if (isMe) {
      final homeController = Get.put(HomeViewController());
      Get.dialog(
        HouseWorkHistoryDeleteDialog(
          houseWorkName: houseWorkName,
          categoryName: categoryName,
          onPressed: () async {
            await onTapDelete(pointHistoryId: pointHistoryId);
            Get.back();
            Get.dialog(
              NormalCompletedDialog(
                message: '家事を取り消しました',
                onPressed: () {
                  Get.back();
                  homeController.onTapGetUnreadCount();
                },
              ),
            );
          },
        ),
      );
    }
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
      final nextPointHistories = await api.getUserPointHistoryList(userId: userId, page: page + 1);
      pointHistories.firstWhere((element) => element.userId == userId).points = [
        ...pointHistories.firstWhere((element) => element.userId == userId).points,
        ...nextPointHistories
      ];
      pointHistories.firstWhere((element) => element.userId == userId).currentPage = page + 1;
      pointHistories.value = [...pointHistories];
    });
  }

  Future<void> onTapNextTotalPage({required int page}) async {
    await callAsyncApi(() async {
      totalNextPointHistory.value = await api.getTotalPointHistory(page: page + 1);
      totalNextPointHistories.value = totalNextPointHistory()?.points ?? [];
      totalPointHistories.value = [...totalPointHistories(), ...totalNextPointHistories()];
      totalCurrentPage.value = totalNextPointHistory()?.currentPage ?? 1;
    });
  }
}
