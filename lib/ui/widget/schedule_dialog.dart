import 'package:cajico_app/ui/widget/primary_small_button.dart';
import 'package:cajico_app/ui/widget/primary_small_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepeatScheduleDialog extends StatelessWidget {
  const RepeatScheduleDialog({
    super.key,
    required this.onPressedOnly,
    required this.onPressedAfter,
    required this.onPressedNormal,
  });

  final VoidCallback onPressedOnly;
  final VoidCallback onPressedAfter;
  final VoidCallback onPressedNormal;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      title: const Text('更新しますか？'),
      children: [
        SimpleDialogOption(
          onPressed: onPressedOnly,
          child: const PrimarySmallButton(text: 'この予定'),
        ),
        SimpleDialogOption(
          onPressed: onPressedAfter,
          child: const PrimarySmallButton(text: 'これ以降の予定'),
        ),
        SimpleDialogOption(
          onPressed: onPressedNormal,
          child: const PrimarySmallButton(text: 'すべての予定'),
        ),
        SimpleDialogOption(
          onPressed: () => Get.back(),
          child: const PrimarySmallOutlineButton(text: 'キャンセル'),
        ),
      ],
    );
  }
}
