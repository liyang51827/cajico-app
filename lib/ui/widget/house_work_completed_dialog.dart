import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/widget/primary_small_button.dart';
import 'package:flutter/material.dart';

class HouseWorkCompletedDialog extends StatelessWidget {
  const HouseWorkCompletedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      title: Column(
        children: const [
          Text('お疲れさまです！', style: TextStyle(fontWeight: FontWeight.bold)),
          verticalSpaceSmall,
          Text('80ポイント獲得しました', style: TextStyle(fontSize: 16)),
          verticalSpaceMedium,
          Image(image: AssetImage('assets/images/other_child_care.png'), width: 200)
        ],
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const PrimarySmallButton(text: '戻る'))
        ),
      ],
    );
  }
}
