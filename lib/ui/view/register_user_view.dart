import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/controller/register_view_controller.dart';
import 'package:cajico_app/ui/widget/primary_button.dart';
import 'package:cajico_app/ui/widget/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../widget/cajico_drop_down.dart';
import '../widget/cajico_text_form_field.dart';
import '../widget/loading_stack.dart';

class RegisterUserView extends StatelessWidget {
  RegisterUserView({super.key, this.familyId, this.token});

  final focusNode = FocusNode();
  final String? familyId;
  final String? token;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterViewController());
    final familyInfo = controller.newFamilyData;
    if (familyId != null && token != null) {
      familyInfo.familyId.value = familyId!;
      familyInfo.type.value = 'invite';
      familyInfo.token.value = token!;
    }

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
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 24),
                child: Column(
                  children: [
                    const ProgressBar(step: 3),
                    verticalSpaceLarge,
                    const Text('ユーザー情報を入力してください', textAlign: TextAlign.center),
                    verticalSpaceLarge,
                    GestureDetector(
                        onTap: () => controller.onTapSelectImage(),
                        child: Obx(() => Stack(
                              children: [
                                familyInfo.iconImage() != null
                                    ? CircleAvatar(
                                        radius: 40,
                                        backgroundImage: FileImage(familyInfo.iconImage()!),
                                        backgroundColor: Colors.white,
                                      )
                                    : const CircleAvatar(
                                        radius: 40,
                                        backgroundImage:
                                            AssetImage('assets/images/default_user_icon.png'),
                                        backgroundColor: Colors.white,
                                      ),
                                Positioned(
                                  bottom: 3,
                                  right: 3,
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    decoration:
                                        const BoxDecoration(shape: BoxShape.circle, color: gray2),
                                    child:
                                        const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                                  ),
                                ),
                              ],
                            ))),
                    verticalSpaceLarge,
                    CajicoTextFormField(
                      label: 'お名前',
                      maxLines: 1,
                      initValue: '',
                      onChanged: (value) => familyInfo.userName.value = value,
                      validator: (value) =>
                          controller.validateInputEditData(value: value, maxLength: 5).message,
                    ),
                    verticalSpaceMedium,
                    CajicoDropDown(
                      onChanged: (value) => familyInfo.positionId.value = value!,
                      items: const [
                        DropdownMenuItem(value: 1, child: Text('旦那さん')),
                        DropdownMenuItem(value: 2, child: Text('奥さん')),
                        DropdownMenuItem(value: 3, child: Text('息子さん')),
                        DropdownMenuItem(value: 4, child: Text('娘さん')),
                        DropdownMenuItem(value: 5, child: Text('おじいちゃん')),
                        DropdownMenuItem(value: 6, child: Text('おばあちゃん')),
                        DropdownMenuItem(value: 7, child: Text('おじさん')),
                        DropdownMenuItem(value: 8, child: Text('おばさん')),
                        DropdownMenuItem(value: 9, child: Text('彼氏さん')),
                        DropdownMenuItem(value: 10, child: Text('彼女さん')),
                      ],
                      labelText: '家族での立場',
                    ),
                    verticalSpaceMedium,
                    CajicoTextFormField(
                      label: 'パスワード',
                      initValue: '',
                      obscureText: true,
                      maxLines: 1,
                      onChanged: (value) => familyInfo.password.value = value,
                      validator: (value) => controller
                          .validateInputPasswordData(value: value, minLength: 8, maxLength: 20)
                          .message,
                    ),
                    verticalSpaceSmall,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        '※家族パスワードは8文字以上20文字以下の半角英数字でご入力ください。',
                        style: TextStyle(color: gray4, fontSize: 13),
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
                label: '登録する',
                onPressed: () => controller.onTapCreateUser(),
                isValid: controller.isRegisterUserValid && familyInfo.positionId() != 0)),
          ),
        ),
      ),
    );
  }
}
