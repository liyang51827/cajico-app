import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/view/email_send_view.dart';
import 'package:cajico_app/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/login_view_controller.dart';
import '../widget/cajico_text_form_field.dart';
import '../widget/loading_stack.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginViewController());
    final loginInfo = controller.loginData;

    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: const Text('ログイン', style: TextStyle(color: gray2)),
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(fontSize: 22),
          ),
          body: GetLoadingStack<LoginViewController>(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.only(right: 16, left: 16, top: 40, bottom: 24),
                child: Column(
                  children: [
                    const Text('メールアドレスとパスワードを\n入力してください', textAlign: TextAlign.center),
                    verticalSpaceLarge,
                    CajicoTextFormField(
                      label: 'メールアドレス',
                      initValue: '',
                      onChanged: (value) => loginInfo.email.value = value,
                      validator: (value) => controller.validateInputEmailData(value).message,
                    ),
                    verticalSpaceMedium,
                    CajicoTextFormField(
                      label: 'パスワード',
                      initValue: '',
                      obscureText: true,
                      maxLines: 1,
                      onChanged: (value) => loginInfo.password.value = value,
                      validator: (value) =>
                          controller.validateInputEditData(value: value, maxLength: 20).message,
                    ),
                    verticalSpaceMediumLarge,
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('パスワードをお忘れの方は', style: TextStyle(fontSize: 13)),
                          InkWell(
                            child: const Text('こちら',
                                style: TextStyle(color: primaryColor, fontSize: 13)),
                            onTap: () => Get.to(() => EmailSendView(type: 'reset')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(24),
            child: Obx(() => PrimaryButton(
                label: 'ログイン',
                isValid: controller.isLoginButtonValid,
                onPressed: () {
                  controller.onTapLogin();
                })),
          ),
        ),
      ),
    );
  }
}
