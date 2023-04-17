import 'package:cajico_app/model/house_works.dart';
import 'package:cajico_app/ui/controller/home_view_controller.dart';
import 'package:get/get.dart';
import '../view/home_view.dart';
import '../widget/house_work_dialog.dart';
import 'base_view_controller.dart';

class HouseWorkViewController extends BaseViewController {
  HouseWorkViewController({required this.houseWorkCategoryId});

  final int houseWorkCategoryId;
  final RxList<HouseWork> houseWorks = <HouseWork>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      houseWorks.value = await api.getHouseWorksList(houseWorkCategoryId: houseWorkCategoryId);
    });
  }

  Future<void> onTapCompleteDialog({required int houseWorkId, required int point}) async {
    final homeController = HomeViewController();
    Get.back();
    await completeApi(houseWorkId: houseWorkId);
    Get.dialog(HouseWorkCompletedDialog(
      point: point,
      onPressed: () {
        Get.back();
        Get.to(() => const HomeView());
        homeController.fetchData();
      },
    ));
  }

  Future<void> completeApi({required int houseWorkId}) async {
    await callAsyncApi(() async {
      await api.postCompleteHouseWork(houseWorkId: houseWorkId);
    });
  }
}
