import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/widget/primary_small_button.dart';
import 'package:cajico_app/ui/widget/primary_small_outline_button.dart';
import 'package:flutter/material.dart';

class HouseWorkCompleteDialog extends StatelessWidget {
  const HouseWorkCompleteDialog({super.key,
    required this.houseWorkName,
    required this.point,
    required this.onPressed,
  });

  final String houseWorkName;
  final int point;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Column(
        children: [
          Text(houseWorkName, style: const TextStyle(fontWeight: FontWeight.bold)),
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(point.toString(),
                  style: TextStyle(
                    color: point < 25 ? lowColor : point < 50 ? middleColor : point < 75 ? secondaryColor : point < 100 ? primaryColor : highestColor,
                    fontSize: 24,
                  )),
              const Text(' ポイント', style: TextStyle(fontSize: 16))
            ],
          ),
          verticalSpaceMedium,
          const Text('この家事をクリアした？', style: TextStyle(fontSize: 16))
        ],
      ),
      children: [
        SimpleDialogOption(
          onPressed: onPressed,
          child: const PrimarySmallButton(text: 'はい！'),
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

class HouseWorkCompletedDialog extends StatelessWidget {
  const HouseWorkCompletedDialog({
    super.key,
    required this.point,
    required this.onPressed,
  });

  final int point;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Column(
        children: [
          const Text('お疲れさまです！', style: TextStyle(fontWeight: FontWeight.bold)),
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(point.toString(),
                  style: TextStyle(
                    color: point < 25 ? lowColor : point < 50 ? middleColor : point < 75 ? secondaryColor : point < 100 ? primaryColor : highestColor,
                    fontSize: 24,
                  )),
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
                onPressed: onPressed,
                child: const PrimarySmallButton(text: '戻る'))),
      ],
    );
  }
}
