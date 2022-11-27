import 'package:cajico_app/ui/widget/primary_small_button.dart';
import 'package:flutter/material.dart';

class NormalDialog extends StatelessWidget {
  const NormalDialog({
    super.key,
    required this.message
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      title: Text(
        message,
        textAlign: TextAlign.center
      ),
      children: [
        SimpleDialogOption(
          child: const PrimarySmallButton(text: 'OK'),
          onPressed: () {
            Navigator.pop(context, '1が選択されました');
          },
        )
      ],
    );
  }
}
