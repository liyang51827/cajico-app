import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/controller/register_view_controller.dart';
import 'package:cajico_app/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../widget/cajico_text_form_field.dart';
import '../widget/loading_stack.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key, required this.token});

  final String token;
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterViewController());

    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: const Text('パスワード再設定', style: TextStyle(color: gray2)),
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(fontSize: 22),
          ),
          body: GetLoadingStack<RegisterViewController>(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 24),
                child: Column(
                  children: [
                    verticalSpaceLarge,
                    const Text('パスワードを再設定してください', textAlign: TextAlign.center),
                    verticalSpaceLarge,
                    CajicoTextFormField(
                      label: '新パスワード',
                      initValue: '',
                      obscureText: true,
                      maxLines: 1,
                      onChanged: (value) => controller.password.value = value,
                      validator: (value) =>
                      controller.validateInputPasswordData(value: value, minLength: 8, maxLength: 20).message,
                    ),
                    verticalSpaceMedium,
                    CajicoTextFormField(
                      label: '新パスワード（確認）',
                      initValue: '',
                      obscureText: true,
                      maxLines: 1,
                      onChanged: (value) => controller.passwordConfirm.value = value,
                      validator: (value) =>
                          controller.validateInputPasswordConfirmData(value: value).message,
                    ),
                    verticalSpaceSmall,
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          '※パスワードは8文字以上20文字以下の半角英数字でご入力ください。',
                          style: TextStyle(color: gray4, fontSize: 13),
                        )),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Obx(
              () => PrimaryButton(
                label: '設定する',
                isValid: controller.isResetPasswordValid,
                onPressed: () => {
                  controller.onTapResetPassword(token: token),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
