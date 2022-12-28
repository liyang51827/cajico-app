import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/widget/primary_small_button.dart';
import 'package:cajico_app/ui/widget/primary_small_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../controller/reward_detail_view_controller.dart';

class RewardCompleteDialog extends GetView<RewardDetailViewController> {
  RewardCompleteDialog({
    super.key,
    required this.rewardId,
    required this.rewardName
  });

  final int rewardId;
  final String rewardName;
  final bodyTextController = TextEditingController();
  String body = '';

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      insetPadding: const EdgeInsets.all(0),
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
            onChanged: (value) => body = value,
          ),
        ],
      ),
      children: [
        SimpleDialogOption(
          onPressed: () {
            controller.onTapComplete(rewardId: rewardId, body: body);
            Navigator.pop(context, true);
          },
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
