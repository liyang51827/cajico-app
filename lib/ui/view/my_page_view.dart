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

class MyPageView extends StatelessWidget {
  MyPageView({super.key});

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black54),
        centerTitle: true,
        title: const Text('マイページ', style: TextStyle(color: gray2)),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 22),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
          ],
        ),
      ),
    );
  }
}
