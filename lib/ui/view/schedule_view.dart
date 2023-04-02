import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:flutter/material.dart';
import '../widget/background.dart';
import '../widget/header.dart';

class AdminNoticeDetailView extends StatelessWidget {
  const AdminNoticeDetailView({
    super.key,
    required this.date,
    required this.title,
    required this.message,
  });

  final String date;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray7,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: Header(
          imageUrl: 'assets/images/logo.png',
          title: 'スケジュール',
        ),
      ),
      body: Background(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
                verticalSpaceMediumSmall,
                Container(
                    width: double.infinity,
                    child: Text(
                      date,
                      textAlign: TextAlign.right,
                    )),
                verticalSpaceMediumSmall,
                Text(message)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
