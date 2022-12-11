import 'package:cajico_app/model/point_history.dart';
import 'package:get/get.dart';
import 'base_view_controller.dart';

class HistoryViewController extends BaseViewController {

  final RxList<PointHistory> pointHistories = <PointHistory>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      pointHistories.value = await api.getPointHistoryList();
    });
  }
}
