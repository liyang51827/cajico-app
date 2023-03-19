import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/controller/inquiry_view_controller.dart';
import 'package:cajico_app/ui/widget/normal_completed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/base_view_controller.dart';
import '../controller/home_view_controller.dart';
import '../widget/cajico_text_form_field.dart';
import '../widget/loading_stack.dart';
import '../widget/normal_dialog.dart';
import '../widget/primary_button.dart';

class InquiryView extends StatelessWidget {
  InquiryView({super.key});

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InquiryViewController());
    final homeController = Get.put(HomeViewController());
    final baseController = Get.put(BaseViewController());
    final inquiryInfo = controller.inquiryData;
    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: const Text('ご意見箱', style: TextStyle(color: gray2)),
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(fontSize: 22),
          ),
          body: GetLoadingStack<InquiryViewController>(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      '追加してほしい機能や\n改善して欲しい箇所がありましたら\nお気軽にご連絡ください。\nできる限りご希望に添えるよう改善いたします。',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  verticalSpaceLarge,
                  CajicoTextFormField(
                    label: 'タイトル',
                    onChanged: (newValue) => inquiryInfo.title.value = newValue,
                    initValue: '',
                    validator: (value) =>
                        controller.validateInputEditData(value: value, maxLength: 20).message,
                  ),
                  verticalSpaceMedium,
                  CajicoTextFormField(
                    label: 'ご意見 / 改善点など',
                    onChanged: (newValue) => inquiryInfo.body.value = newValue,
                    initValue: '',
                    minLines: 10,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    validator: (value) =>
                        controller.validateInputEditData(value: value, maxLength: 500).message,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24),
            child: Obx(() => PrimaryButton(
                  label: '送信する',
                  isValid: controller.isInquiryButtonValid,
                  onPressed: () => Get.dialog(
                    NormalDialog(
                      message: '送信しますか？',
                      onPressed: () async {
                        Get.back();
                        await controller.onTapInquiry();
                        Get.dialog(
                          NormalCompletedDialog(
                            message: '送信されました',
                            onPressed: () {
                              Get.back();
                              homeController.onTapGetUnreadCount();
                              baseController.onTapBottomNavigation(0);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
