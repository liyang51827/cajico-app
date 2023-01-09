import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/widget/primary_small_button.dart';
import 'package:cajico_app/ui/widget/primary_small_outline_button.dart';
import 'package:flutter/material.dart';

class HouseWorkCompleteDialog extends StatelessWidget {
  const HouseWorkCompleteDialog({
    super.key,
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
              Text(point.toString(), style: const TextStyle(color: primaryColor, fontSize: 24)),
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
