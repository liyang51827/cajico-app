import 'package:cajico_app/ui/view/home_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base_view_controller.dart';

class LoginViewController extends BaseViewController {
  LoginViewController();

  Future<void> onTapLogin({required String email, required String password}) async {
    String? result = '';
    final prefs = await SharedPreferences.getInstance();
    await callAsyncApi(() async {
      result = await api.login(email: email, password: password);
    });
    if (result != null) {
      print(result);
      prefs.setString('token', result!);
      Get.to(const HouseWork());
    }
  }
}
