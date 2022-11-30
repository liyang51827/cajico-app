import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/view/home_view.dart';
import 'package:cajico_app/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          backgroundColor: gray7,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: const Text('ログイン', style: TextStyle(color: gray2)),
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(fontSize: 22),
          ),
          body: Container(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 40, bottom: 24),
            child: Column(
              children: [
                const Text(
                  'メールアドレスとパスワードを\n入力してください',
                  textAlign: TextAlign.center,
                ),
                verticalSpaceLarge,
                TextFormField(
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                      labelText: 'メールアドレス',
                      labelStyle: const TextStyle(color: gray3),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: gray6)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primaryColor))),
                ),
                verticalSpaceMedium,
                TextFormField(
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                      labelText: 'パスワード',
                      labelStyle: const TextStyle(color: gray3),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: gray6)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primaryColor))),
                ),
                verticalSpaceMediumLarge,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'メールアドレス及びパスワードをお忘れの方は',
                        style: TextStyle(fontSize: 13),
                      ),
                      InkWell(
                        child: const Text(
                          'こちら',
                          style: TextStyle(color: primaryColor, fontSize: 13),
                        ),
                        onTap: () => Get.to(() => const HouseWork()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: PrimaryButton(
              label: 'ログイン',
              onPressed: () => Get.to(const HouseWork()),
            ),
          ),
        )
      )
    );
  }
}
