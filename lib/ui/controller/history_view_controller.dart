import 'package:cached_network_image/cached_network_image.dart';
import 'package:cajico_app/model/point_history.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/stamp.dart';
import '../widget/house_work_history_delete_dialog.dart';
import '../widget/normal_completed_dialog.dart';
import 'base_view_controller.dart';
import 'home_view_controller.dart';

class HistoryViewController extends BaseViewController {
  // 全体家事履歴関連の変数
  final totalPointHistory = Rxn<TotalPointHistory>();
  final totalNextPointHistory = Rxn<TotalPointHistory>();
  final RxList<Point> totalPointHistories = <Point>[].obs;
  final RxList<Point> totalNextPointHistories = <Point>[].obs;
  final totalCurrentPage = 1.obs;
  final RxList<Stamp> stamps = <Stamp>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      await Future.wait([
        () async {
          totalPointHistory.value = await api.getTotalPointHistory();
          totalPointHistories.value = totalPointHistory()?.points ?? [];
          totalNextPointHistories.value = [];
          totalCurrentPage.value = 1;
        }(),
        () async {
          stamps.value = await api.getStampList();
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
            Get.back();
            await deleteApi(pointHistoryId: pointHistoryId);
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

  Future<void> deleteApi({required int pointHistoryId}) async {
    var result = false;
    await callAsyncApi(() async {
      result = await api.deletePointHistory(pointHistoryId: pointHistoryId);
    });
    if (result) {
      fetchData();
    }
  }

  Future<void> onTapNextTotalPage({required int page}) async {
    await callAsyncApi(() async {
      totalNextPointHistory.value = await api.getTotalPointHistory(page: page + 1);
      totalNextPointHistories.value = totalNextPointHistory()?.points ?? [];
      totalPointHistories.value = [...totalPointHistories(), ...totalNextPointHistories()];
      totalCurrentPage.value = totalNextPointHistory()?.currentPage ?? 1;
    });
  }

  Future<void> onTapStampDialog() async {
    Get.dialog(SimpleDialog(
      title: Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (var stamp in stamps()) ...{
              SizedBox(
                width: 40,
                child: CachedNetworkImage(imageUrl: stamp.stampUrl),
              ),
            },
          ],
        ),
      ),
    ));
  }
}
