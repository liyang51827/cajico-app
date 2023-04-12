import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:flutter/material.dart';
import '../widget/background.dart';

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
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black54),
        centerTitle: true,
        title: const Text('運営お知らせ', style: TextStyle(color: gray2)),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 22),
      ),
      body: Background(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
                verticalSpaceMediumSmall,
                SizedBox(
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
