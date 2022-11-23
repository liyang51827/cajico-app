import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/widget/normal_dialog.dart';
import 'package:flutter/material.dart';

import '../widget/primary_button.dart';
import '../widget/reward_request_dialog.dart';

class InquiryView extends StatelessWidget {
  const InquiryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray7,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black54),
        centerTitle: true,
        title: const Text('ご意見箱', style: TextStyle(color: gray2)),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 22)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: const Text(
                '追加してほしい機能や\n改善して欲しい箇所がありましたら\nお気軽にご連絡ください。\nできる限りご希望に添えるよう改善いたします。',
                textAlign: TextAlign.center,
              ),
            ),
            verticalSpaceLarge,
            TextField(
              cursorColor: primaryColor,
              decoration: InputDecoration(
                hintText: 'タイトル',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: gray6)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor))
              ),
            ),
            verticalSpaceMedium,
            TextField(
              cursorColor: primaryColor,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  hintText: 'ご意見 / 改善点など',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: gray6)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: primaryColor))
              ),
            ),
            verticalSpaceMedium,
            PrimaryButton(
              label: '送信する',
              onPressed: () {
                showDialog<void>(
                    context: context,
                    builder: (_) {
                      return const NormalDialog(message: '送信されました');
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
