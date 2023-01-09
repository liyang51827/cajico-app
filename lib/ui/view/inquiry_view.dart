import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/controller/inquiry_view_controller.dart';
import 'package:cajico_app/ui/widget/normal_completed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/base_view_controller.dart';
import '../controller/home_view_controller.dart';
import '../widget/cajico_text_form_field.dart';
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
    String title = '';
    String body = '';
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
          body: SingleChildScrollView(
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
                  onChanged: (value) => title = value,
                  initValue: '',
                ),
                verticalSpaceMedium,
                CajicoTextFormField(
                  label: 'ご意見 / 改善点など',
                  onChanged: (value) => body = value,
                  initValue: '',
                  minLines: 10,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              label: '送信する',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return NormalDialog(
                        message: '送信しますか？',
                        onPressed: () {
                          controller.onTapInquiry(title: title, body: body);
                          Navigator.pop(context, true);
                        },
                      );
                    }).then((value) {
                  if (value) {
                    return showDialog(
                      context: context,
                      builder: (context) => NormalCompletedDialog(
                        message: '送信されました',
                        onPressed: () {
                          Navigator.pop(context);
                          homeController.onTapGetUnreadCount();
                          baseController.onTapBottomNavigation(0);
                        },
                      ),
                    );
                  }
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
