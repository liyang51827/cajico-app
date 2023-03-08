import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/controller/register_view_controller.dart';
import 'package:cajico_app/ui/widget/primary_button.dart';
import 'package:cajico_app/ui/widget/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../widget/cajico_text_form_field.dart';
import '../widget/loading_stack.dart';

class RegisterUserView extends StatelessWidget {
  RegisterUserView({
    super.key,
    required this.type,
    required this.token,
    required this.familyName,
    required this.familyCode,
  });

  final String type;
  final String token;
  final String familyName;
  final String familyCode;
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterViewController());
    final familyInfo = controller.newFamilyData;

    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: const Text('ユーザー登録', style: TextStyle(color: gray2)),
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(fontSize: 22),
          ),
          body: GetLoadingStack<RegisterViewController>(
            child: Container(
              padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 24),
              child: Column(
                children: [
                  const ProgressBar(step: 3),
                  verticalSpaceLarge,
                  const Text('ユーザー情報を入力してください', textAlign: TextAlign.center),
                  verticalSpaceLarge,
                  CajicoTextFormField(
                    label: 'お名前',
                    initValue: '',
                    onChanged: (value) => familyInfo.familyName.value = value,
                    validator: (value) =>
                        controller.validateInputEditData(value: value, maxLength: 5).message,
                  ),
                  verticalSpaceMedium,
                  CajicoTextFormField(
                    label: 'パスワード',
                    initValue: '',
                    onChanged: (value) => familyInfo.familyCode.value = value,
                    validator: (value) =>
                        controller.validateInputEditData(value: value, maxLength: 10).message,
                  ),
                  verticalSpaceSmall,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      '※家族コードは8文字以上20文字以下の半角英数字でご入力ください。',
                      style: TextStyle(color: gray4, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Obx(() => PrimaryButton(
                label: '次へ', isValid: controller.isRegisterFamilyValid, onPressed: () {})),
          ),
        ),
      ),
    );
  }
}
