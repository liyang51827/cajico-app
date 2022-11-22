import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../common/ui_helper.dart';
import '../widget/house_work_card.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray7,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black54),
        centerTitle: true,
        title: const Text('お知らせ', style: TextStyle(color: gray2)),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 22)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            _NotificationDetail(date: '2022年10月11日 18:00', message: 'かつのりさんが家事「晩ごはん準備」をクリアしました！'),
            _NotificationDetail(date: '2022年10月11日 18:00', message: 'かつのりさんが家事「晩ごはん準備」をクリアしました！'),
            _NotificationDetail(date: '2022年10月11日 18:00', message: 'かつのりさんが家事「晩ごはん準備」をクリアしました！'),
            _NotificationDetail(date: '2022年10月11日 18:00', message: 'かつのりさんが家事「晩ごはん準備」をクリアしました！'),
            _NotificationDetail(date: '2022年10月11日 18:00', message: 'かつのりさんが家事「晩ごはん準備」をクリアしました！'),
            _NotificationDetail(date: '2022年10月11日 18:00', message: 'かつのりさんが家事「晩ごはん準備」をクリアしました！'),
            _NotificationDetail(date: '2022年10月11日 18:00', message: 'かつのりさんが家事「晩ごはん準備」をクリアしました！'),
            _NotificationDetail(date: '2022年10月11日 18:00', message: 'かつのりさんが家事「晩ごはん準備」をクリアしました！'),
            _NotificationDetail(date: '2022年10月11日 18:00', message: 'かつのりさんが家事「晩ごはん準備」をクリアしました！'),
            _NotificationDetail(date: '2022年10月11日 18:00', message: 'かつのりさんが家事「晩ごはん準備」をクリアしました！'),
            _NotificationDetail(date: '2022年10月11日 18:00', message: 'かつのりさんが家事「晩ごはん準備」をクリアしました！'),
            _NotificationDetail(date: '2022年10月11日 18:00', message: 'かつのりさんが家事「晩ごはん準備」をクリアしました！'),
          ],
        ),
      ),
    );
  }
}

class _NotificationDetail extends StatelessWidget {
  const _NotificationDetail({
    required this.date,
    required this.message,
  });
  final String date;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12, //枠線の色
              width: 1, //枠線の太さ
            ),
          ),
          color: Colors.white
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(date),
          verticalSpaceTiny,
          Container(
            width: double.infinity,
            child: Text(message)
          )
        ],
      )
    );
  }
}
