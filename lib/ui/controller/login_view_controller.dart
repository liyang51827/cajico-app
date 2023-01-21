import 'package:cajico_app/ui/view/home_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/form_validation.dart';
import '../../model/login_data.dart';
import '../../util/form_validator.dart';
import 'base_view_controller.dart';

class LoginViewController extends BaseViewController {
  LoginViewController();

  final loginData = LoginData(
    email: ''.obs,
    password: ''.obs,
  );

  FormValidation validateInputEditData({String? value, required maxLength}) =>
      FormValidator.validateEditBasicInfo(value: value, maxLength: maxLength);

  bool get isInquiryButtonValid =>
      validateInputEditData(value: loginData.email(), maxLength: 20).isValid &&
          validateInputEditData(value: loginData.password(), maxLength: 500).isValid;


  Future<void> onTapLogin() async {
    String? result = '';
    final prefs = await SharedPreferences.getInstance();
    await callAsyncApi(() async {
      result = await api.login(loginData);
    });
    if (result != '') {
      prefs.setString('token', result!);
      Get.to(const HomeView());
    }
  }
}
