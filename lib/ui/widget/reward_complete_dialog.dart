import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/widget/primary_small_button.dart';
import 'package:cajico_app/ui/widget/primary_small_outline_button.dart';
import 'package:flutter/material.dart';

class RewardCompleteDialog extends StatelessWidget {
  RewardCompleteDialog({
    super.key,
    required this.rewardName,
    required this.onPressed
  });

  final String rewardName;
  final VoidCallback onPressed;
  final bodyTextController = TextEditingController();
  String body = '';

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Column(
        children: [
          Text(rewardName, style: const TextStyle(fontWeight: FontWeight.bold)),
          verticalSpaceMedium,
          const Text('ねぎらいを完了しますか？', style: TextStyle(fontSize: 16)),
          verticalSpaceMedium,
          TextFormField(
            controller: bodyTextController,
            cursorColor: primaryColor,
            keyboardType: TextInputType.multiline,
            minLines: 3,
            maxLines: 3,
            decoration: InputDecoration(
                labelText: 'ひとことメッセージ',
                labelStyle: const TextStyle(color: gray3),
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: gray6)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: primaryColor))),
            onChanged: (value) {
              body = value;
            },
          ),
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
