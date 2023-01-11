import 'package:cajico_app/model/my_page.dart';
import 'package:get/get.dart';
import 'base_view_controller.dart';

class MyPageViewController extends BaseViewController {
  final user = Rxn<MyPage>();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await callAsyncApi(() async {
      user.value = await api.getMyPage();
    });
  }
}
