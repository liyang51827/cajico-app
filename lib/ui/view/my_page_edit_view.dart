import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/cajico_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/my_page_edit_view_controller.dart';
import '../widget/cajico_cashed_network_image.dart';
import '../widget/cajico_drop_down.dart';
import '../widget/loading_stack.dart';
import '../widget/normal_dialog.dart';
import '../widget/primary_button.dart';

class MyPageEditView extends StatelessWidget {
  MyPageEditView({
    super.key,
    required this.initFamilyName,
    required this.initFamilyCode,
    required this.initUserName,
    required this.iconUrl,
    required this.initPosition,
    required this.email,
    required this.isOnlyMe,
  });

  final String initFamilyName;
  final String initFamilyCode;
  final String initUserName;
  final String? iconUrl;
  final int initPosition;
  final String email;
  final bool isOnlyMe;
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyPageEditViewController());
    final myPageInfo = controller.myPageData;
    myPageInfo.familyName.value = initFamilyName;
    myPageInfo.familyCode.value = initFamilyCode;
    myPageInfo.userName.value = initUserName;
    myPageInfo.positionId.value = initPosition;
    myPageInfo.iconImage.value = null;

    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: const Text('マイページの編集', style: TextStyle(color: gray2)),
            backgroundColor: secondaryColor,
            titleTextStyle: const TextStyle(fontSize: 22),
            actions: [
              PopupMenuButton(
                offset: const Offset(0, 50),
                onSelected: (result) {
                  if (result == 1) {
                    Get.dialog(NormalDialog(
                        message: '退会してもよいですか？\n退会すると全てのデータが削除されます',
                        onPressed: () {
                          controller.onTapDelete(isOnlyMe: isOnlyMe);
                        }));
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: 1,
                      child: Text('退会する'),
                    ),
                  ];
                },
              )
            ],
          ),
          body: GetLoadingStack<MyPageEditViewController>(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  verticalSpaceLarge,
                  GestureDetector(
                      onTap: () => controller.onTapSelectImage(),
                      child: Obx(() => Stack(
                            children: [
                              myPageInfo.iconImage() != null
                                  ? CircleAvatar(
                                      radius: 40,
                                      backgroundImage: FileImage(myPageInfo.iconImage()!),
                                      backgroundColor: Colors.white,
                                    )
                                  : iconUrl != null
                                      ? CajicoCachedNetworkIconImage(imageUrl: iconUrl!, radius: 40)
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
                    initValue: initFamilyName,
                    label: '家族名',
                    maxLines: 1,
                    onChanged: (value) => myPageInfo.familyName.value = value,
                    validator: (value) =>
                        controller.validateInputEditData(value: value, maxLength: 5).message,
                  ),
                  verticalSpaceMedium,
                  CajicoTextFormField(
                    initValue: initFamilyCode,
                    obscureText: true,
                    maxLines: 1,
                    label: '家族パスワード',
                    onChanged: (value) => myPageInfo.familyCode.value = value,
                    validator: (value) => controller
                        .validateInputPasswordData(value: value, minLength: 8, maxLength: 20)
                        .message,
                  ),
                  verticalSpaceMedium,
                  CajicoTextFormField(
                    initValue: initUserName,
                    label: '名前',
                    maxLines: 1,
                    onChanged: (value) => myPageInfo.userName.value = value,
                    validator: (value) =>
                        controller.validateInputEditData(value: value, maxLength: 5).message,
                  ),
                  verticalSpaceMedium,
                  CajicoDropDown(
                    onChanged: (value) => myPageInfo.positionId.value = value!,
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
                    initialValue: initPosition,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24),
            child: Obx(
              () => PrimaryButton(
                label: '変更する',
                isValid: controller.isUpdateMyPageValid &&
                    (myPageInfo.familyName() != initFamilyName ||
                        myPageInfo.familyCode() != initFamilyCode ||
                        myPageInfo.userName() != initUserName ||
                        myPageInfo.positionId() != initPosition ||
                        myPageInfo.iconImage() != null),
                onPressed: () {
                  Get.dialog(
                    NormalDialog(
                      message: '変更しますか？',
                      onPressed: () async {
                        Get.back();
                        await controller.onTapUpdateMyPage();
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
