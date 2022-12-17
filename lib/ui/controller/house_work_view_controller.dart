import 'package:cajico_app/model/house_works.dart';
import 'package:get/get.dart';
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

  Future<void> onTapComplete({required int houseWorkId}) async {
    await callAsyncApi(() async {
        print(houseWorkId);
        await api.postCompleteHouseWork(houseWorkId: houseWorkId);
    });
  }
}
