import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/cajico_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/my_page_edit_view_controller.dart';

class MyPageEditView extends StatelessWidget {
  MyPageEditView({
    super.key,
    required this.initFamilyName,
    required this.initFamilyCode,
    required this.initUserName,
    required this.iconUrl,
    required this.initPosition,
    required this.email,
  });

  final String initFamilyName;
  final String initFamilyCode;
  final String initUserName;
  final String iconUrl;
  final String initPosition;
  final String email;
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyPageEditViewController());
    final myPageInfo = controller.myPageData;
    myPageInfo.familyName.value = initFamilyName;
    myPageInfo.familyCode.value = initFamilyCode;
    myPageInfo.userName.value = initUserName;
    myPageInfo.position.value = initPosition;

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
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                verticalSpaceLarge,
                verticalSpaceMedium,
                CajicoTextFormField(
                  initValue: initFamilyName,
                  label: '家族名',
                  onChanged: (value) => myPageInfo.familyName.value = value,
                  // validator: (value) =>
                  // controller
                  //     .validateInputEditData(value: value, maxLength: 10)
                  //     .message,
                ),
                verticalSpaceMedium,
                CajicoTextFormField(
                  initValue: initFamilyCode,
                  label: '家族コード',
                  onChanged: (value) => myPageInfo.familyCode.value = value,
                  // validator: (value) =>
                  // controller
                  //     .validateInputEditData(value: value, maxLength: 10)
                  //     .message,
                ),
                verticalSpaceMedium,
                CajicoTextFormField(
                  initValue: initUserName,
                  label: '名前',
                  onChanged: (value) => myPageInfo.userName.value = value,
                  // validator: (value) =>
                  // controller
                  //     .validateInputEditData(value: value, maxLength: 10)
                  //     .message,
                ),
              ],
            ),
          ),
          // bottomNavigationBar: Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: Obx(
          //         () =>
          //         PrimaryButton(
          //           label: '変更する',
          //           isValid: controller.isUpdateButtonValid &&
          //               (myPageInfo.rewardName() != initRewardName ||
          //                   myPageInfo.point() != initPoint ||
          //                   myPageInfo.memo() != initMemo),
          //           onPressed: () {
          //             Get.dialog(
          //               NormalDialog(
          //                 message: '更新しますか？',
          //                 onPressed: () async {
          //                   await controller.onTapUpdate();
          //                   Get.back();
          //                   Get.dialog(
          //                     NormalCompletedDialog(
          //                       message: '更新されました',
          //                       onPressed: () {
          //                         Get.back();
          //                         homeController.onTapGetUnreadCount();
          //                         baseController.onTapBottomNavigation(1);
          //                         rewardIndexController.fetchData();
          //                       },
          //                     ),
          //                   );
          //                 },
          //               ),
          //             );
          //           },
          //         ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
