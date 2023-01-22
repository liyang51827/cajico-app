import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/view/home_view.dart';
import 'package:cajico_app/ui/widget/primary_button.dart';
import 'package:cajico_app/ui/widget/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/login_view_controller.dart';
import '../widget/cajico_text_form_field.dart';
import '../widget/loading_stack.dart';

class EmailSendView extends StatelessWidget {
  EmailSendView({super.key, required this.type});

  final String type;
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
            title: const Text('メールアドレス登録', style: TextStyle(color: gray2)),
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(fontSize: 22),
          ),
          body: GetLoadingStack<LoginViewController>(
            child: Container(
              padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 24),
              child: Column(
                children: [
                  const ProgressBar(step: 1),
                  verticalSpaceLarge,
                  const Text('メールアドレスを入力してください', textAlign: TextAlign.center),
                  verticalSpaceLarge,
                  CajicoTextFormField(
                    label: 'メールアドレス',
                    initValue: '',
                    onChanged: (value) => loginInfo.email.value = value,
                    validator: (value) => controller.validateInputEmailData(value).message,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Obx(() => PrimaryButton(
                label: '送信する',
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