import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/controller/register_view_controller.dart';
import 'package:cajico_app/ui/widget/primary_button.dart';
import 'package:cajico_app/ui/widget/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../widget/cajico_text_form_field.dart';
import '../widget/loading_stack.dart';

class RegisterFamilyView extends StatelessWidget {
  RegisterFamilyView({super.key, required this.type, required this.token});

  final String type;
  final String token;
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterViewController());
    final familyInfo = controller.newFamilyData;
    familyInfo.type.value = type;
    familyInfo.token.value = token;

    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: familyInfo.type() == 'new'
                ? const Text('家族登録', style: TextStyle(color: gray2))
                : const Text('家族に参加する', style: TextStyle(color: gray2)),
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
                    const ProgressBar(step: 2),
                    verticalSpaceLarge,
                    if (familyInfo.type() == 'new')
                      const Text('家族の名前と\n他の方が家族に参加するための\n家族コードを設定してください',
                          textAlign: TextAlign.center),
                    if (familyInfo.type() == 'join')
                      const Text('家族名と\n家族コードを入力してください', textAlign: TextAlign.center),
                    verticalSpaceLarge,
                    CajicoTextFormField(
                      label: '家族名',
                      initValue: '',
                      onChanged: (value) => familyInfo.familyName.value = value,
                      validator: (value) =>
                          controller.validateInputEditData(value: value, maxLength: 5).message,
                    ),
                    verticalSpaceMedium,
                    CajicoTextFormField(
                      label: '家族コード',
                      initValue: '',
                      obscureText: true,
                      maxLines: 1,
                      onChanged: (value) => familyInfo.familyCode.value = value,
                      validator: (value) =>
                          controller.validateInputPasswordData(value: value, minLength: 8, maxLength: 20).message,
                    ),
                    verticalSpaceSmall,
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          '※家族コードは8文字以上20文字以下の半角英数字でご入力ください。',
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
                label: '次へ',
                isValid: controller.isRegisterFamilyValid,
                onPressed: () => {
                  controller.onTapConfirmFamily(),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
