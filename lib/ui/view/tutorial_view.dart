import 'package:cajico_app/ui/view/top_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:get/get.dart';

import '../common/app_color.dart';

class TutorialView extends StatelessWidget {
  TutorialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          Get.to(() => const TopView());
        },
        finishCallback: () {
          Get.to(() => const TopView());
        },
        skipText: 'スキップ',
        nextText: '次へ',
        finishText: 'はじめる',
      ),
    );
  }

  final pages = [
    PageModel(
        color: secondaryColor,
        imageAssetPath: 'assets/images/tutorial1.png',
        title: '夫婦で一緒に\n仲良く家事を管理',
        body: '家事・育児は家族みんなで。\n日々の家事に感謝するための家事共有アプリです。',
        doAnimateImage: true),
    PageModel(
        color: Colors.orange[300],
        imageAssetPath: 'assets/images/tutorial2.png',
        title: '家事をこなして\nポイントをゲット',
        body: '家事を完了した人は\nあらかじめ家族で決めたポイントを獲得できます。',
        doAnimateImage: true),
    PageModel(
        color: Colors.red[300],
        imageAssetPath: 'assets/images/tutorial3.png',
        title: '家事をすると\n通知でお知らせ',
        body: 'パートナーに通知でお知らせを。\nあなたの頑張りがしっかり相手に届きます。',
        doAnimateImage: true),
    PageModel(
        color: Colors.pinkAccent[100],
        imageAssetPath: 'assets/images/tutorial4.png',
        title: 'たまったポイントで\nごほうびがもらえる',
        body: 'ごほうびは３種類設定できます。\nあなたの頑張りを家族にねぎらってもらいましょう。',
        doAnimateImage: true),
    PageModel(
        color: Colors.yellowAccent[700],
        imageAssetPath: 'assets/images/tutorial5.png',
        title: '1日の予定も\nカレンダーで管理',
        body: '定期的な予定も設定できます。\n色も予定ごとに自由にカスタマイズ。',
        doAnimateImage: true),
    PageModel(
        color: Colors.green[300],
        imageAssetPath: 'assets/images/tutorial6.png',
        title: '家事の履歴も\nかんたんチェック',
        body: '履歴画面で過去の家事を振り返り。\n自分の履歴は取り消すことができます。',
        doAnimateImage: true),
    PageModel(
        color: Colors.blue[300],
        imageAssetPath: 'assets/images/tutorial7.png',
        title: '家事やごほうびは\n自由にカスタマイズ',
        body: '家族ごとの独自の家事や自分の好きなごほうびへ\n自由に追加・編集できます',
        doAnimateImage: true),
    PageModel.withChild(
        child: const Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Center(
              child: Text(
                "CAJICOで\n家族に感謝を！",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
            )),
        doAnimateChild: true,
        color: primaryColor)
  ];
}
