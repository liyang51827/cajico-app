import 'package:get/get_rx/src/rx_types/rx_types.dart';

class LoginData {
  LoginData({
    required this.email,
    required this.password,
  });

  final RxString email;
  final RxString password;
}
