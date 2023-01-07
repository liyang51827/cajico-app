import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/house_work_view_controller.dart';
import '../widget/house_work_card.dart';
import '../widget/loading_stack.dart';

class RewardEditView extends StatelessWidget {
  const RewardEditView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray7,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black54),
          centerTitle: true,
          title: const Text('ごほうびの編集', style: TextStyle(color: gray2)),
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(fontSize: 22)),
    );
  }
}
