import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:flutter/material.dart';

class HouseWorkCompleteDialog extends StatelessWidget {
  const HouseWorkCompleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Column(
        children: [
          const Text('朝ごはん準備', style: TextStyle(fontWeight: FontWeight.bold, color: gray2)),
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('80', style: TextStyle(color: primaryColor)),
              Text('ポイント', style: TextStyle(fontSize: 16, color: gray2))
            ],
          ),
          verticalSpaceMedium,
          const Text('この家事をクリアした？', style: TextStyle(fontSize: 16, color: gray2))
        ],
      ),
      children: [
        SimpleDialogOption(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(20)
            ),
            child: const Text(
              'はい！',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
              textAlign: TextAlign.center,
            )
          ),
          onPressed: () {
            Navigator.pop(context, '1が選択されました');
          },
        ),
        SimpleDialogOption(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: const Text(
                'いいえ',
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 18
                ),
                textAlign: TextAlign.center,
              )
          ),
          onPressed: () {
            Navigator.pop(context, '2が選択されました');
          },
        )
      ],
    );
  }
}
