import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/widget/primary_small_button.dart';
import 'package:cajico_app/ui/widget/primary_small_outline_button.dart';
import 'package:flutter/material.dart';

class RewardRequestDialog extends StatelessWidget {
  const RewardRequestDialog({
    super.key,
    required this.rewardName,
    required this.point,
  });

  final String rewardName;
  final int point;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Column(
        children: [
          Text(rewardName, style: const TextStyle(fontWeight: FontWeight.bold)),
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(point.toString(), style: const TextStyle(color: primaryColor, fontSize: 24)),
              const Text(' ポイントを使って', style: TextStyle(fontSize: 16))
            ],
          ),
          verticalSpaceMedium,
          const Text('ねぎらってもらいますか？', style: TextStyle(fontSize: 16))
        ],
      ),
      children: [
        SimpleDialogOption(
          child: const PrimarySmallButton(text: 'はい！'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        SimpleDialogOption(
          child: const PrimarySmallOutlineButton(text: 'いいえ'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        )
      ],
    );
  }
}
