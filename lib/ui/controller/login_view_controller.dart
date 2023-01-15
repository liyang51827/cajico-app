import 'base_view_controller.dart';

class LoginViewController extends BaseViewController {
  LoginViewController();

  Future<void> onTapLogin({required String email, required String password}) async {
    await callAsyncApi(() async {
      await api.login(email: email, password: password);
    });
  }
}
