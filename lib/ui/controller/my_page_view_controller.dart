import 'package:cajico_app/model/my_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/top_view.dart';
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

  Future<void> onTapLogout() async {
    var result = false;
    final prefs = await SharedPreferences.getInstance();
    await callAsyncApi(() async {
      result = await api.logout();
    });
    if (result) {
      prefs.remove('token');
      Get.to(() => const TopView());
    }
  }
}
