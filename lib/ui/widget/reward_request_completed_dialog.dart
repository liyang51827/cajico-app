import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/view/reward_view.dart';
import 'package:cajico_app/ui/widget/primary_small_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/reward_view_controller.dart';

class RewardCompletedDialog extends StatelessWidget {
  const RewardCompletedDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RewardViewController());
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Column(
        children: [
          Text(
            message,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          verticalSpaceMedium,
          const Image(
            image: AssetImage('assets/images/other_child_care.png'),
            width: 200,
          )
        ],
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
          child: TextButton(
            onPressed: () {
              Get.to(() => const RewardView());
              controller.fetchData();
            },
            child: const PrimarySmallButton(text: '戻る'),
          ),
        ),
      ],
    );
  }
}
