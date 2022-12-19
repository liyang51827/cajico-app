import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/widget/primary_small_button.dart';
import 'package:cajico_app/ui/widget/primary_small_outline_button.dart';
import 'package:flutter/material.dart';

class HouseWorkHistoryDeleteDialog extends StatelessWidget {
  const HouseWorkHistoryDeleteDialog(
      {super.key,
      required this.categoryName,
      required this.houseWorkName,
      required this.onPressed});

  final String categoryName;
  final String houseWorkName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Column(
        children: [
          Text(categoryName, style: const TextStyle(fontSize: 18)),
          verticalSpaceSmall,
          Text(houseWorkName, style: const TextStyle(fontWeight: FontWeight.bold)),
          verticalSpaceMedium,
          const Text('を取り消しますか？', style: TextStyle(fontSize: 16))
        ],
      ),
      children: [
        SimpleDialogOption(
          onPressed: onPressed,
          child: const PrimarySmallButton(text: 'はい'),
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
