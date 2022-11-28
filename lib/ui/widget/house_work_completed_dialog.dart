import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/widget/primary_small_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/home_view.dart';

class HouseWorkCompletedDialog extends StatelessWidget {
  const HouseWorkCompletedDialog({
    super.key,
    required this.point,
  });
  final int point;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      title: Column(
        children: [
          const Text('お疲れさまです！', style: TextStyle(fontWeight: FontWeight.bold)),
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(point.toString(), style: const TextStyle(color: primaryColor, fontSize: 24)),
              const Text(' ポイント獲得しました', style: TextStyle(fontSize: 16))
            ],
          ),
          verticalSpaceMedium,
          const Image(image: AssetImage('assets/images/other_child_care.png'), width: 200)
        ],
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
          child: TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                Get.to(() => const HouseWork());
              },
              child: const PrimarySmallButton(text: '戻る'))
        ),
      ],
    );
  }
}
