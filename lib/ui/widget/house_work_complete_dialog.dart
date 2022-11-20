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
  });

  final String houseWorkName;
  final int point;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Column(
        children: [
          Text(houseWorkName, style: const TextStyle(fontWeight: FontWeight.bold, color: gray2)),
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(point.toString(), style: const TextStyle(color: primaryColor)),
              const Text('ポイント', style: TextStyle(fontSize: 16, color: gray2))
            ],
          ),
          verticalSpaceMedium,
          const Text('この家事をクリアした？', style: TextStyle(fontSize: 16, color: gray2))
        ],
      ),
      children: [
        SimpleDialogOption(
          child: const PrimarySmallButton(text: 'はい！'),
          onPressed: () {
            Navigator.pop(context, '1が選択されました');
          },
        ),
        SimpleDialogOption(
          child: const PrimarySmallOutlineButton(text: 'いいえ'),
          onPressed: () {
            Navigator.pop(context, '2が選択されました');
          },
        )
      ],
    );
  }
}
