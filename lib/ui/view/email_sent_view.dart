import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/progress_bar.dart';
import 'package:flutter/material.dart';
import '../common/ui_helper.dart';

class EmailSentView extends StatelessWidget {
  const EmailSentView({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black54),
        centerTitle: true,
        title: Text(
          type == 'reset' ? 'パスワード再設定' : 'メールアドレス登録',
          style: const TextStyle(color: gray2),
        ),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 22),
      ),
      body: Container(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 24),
        child: Column(
          children: [
            type != 'reset' ? const ProgressBar(step: 1) : const SizedBox(),
            verticalSpaceLarge,
            const Text('メールをお送りしました',
                style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            verticalSpaceLarge,
            const Text('入力いただいたメールアドレスに確認メールを送信しました。メール内のリンクをタップして登録を進めてください。',
                textAlign: TextAlign.center),
            verticalSpaceLarge,
            const Text('メールが届かない場合は、入力されたメールアドレスが間違っているか、迷惑メールフォルダに入っている可能性がありますのでご確認ください。',
                textAlign: TextAlign.center),
            verticalSpaceLarge,
            const Image(image: AssetImage('assets/images/desk_work.png'), width: 300)
          ],
        ),
      ),
    );
  }
}
