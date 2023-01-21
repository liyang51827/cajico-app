import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_strings.dart';

class DefaultAlertDialog extends StatelessWidget {
  const DefaultAlertDialog({
    super.key,
    this.title,
    this.description,
    this.isConfirmationDialog = false,
    this.positiveLabel = Strings.ok,
    this.negativeLabel = Strings.cancel,
    this.onNegative,
    this.onPositive,
  });

  final String? title;
  final String? description;
  final String positiveLabel;
  final String negativeLabel;
  final bool isConfirmationDialog;
  final VoidCallback? onNegative;
  final VoidCallback? onPositive;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title == null ? null : Text(title!),
      content: description == null ? null : Text(description!),
      actions: <Widget>[
        if (isConfirmationDialog)
          TextButton(
            onPressed: () {
              onNegative?.call();
              Get.back();
            },
            child: Text(negativeLabel),
          ),
        TextButton(
          onPressed: () {
            onPositive?.call();
            Get.back();
          },
          child: Text(positiveLabel, style: const TextStyle(color: primaryColor)),
        ),
      ],
    );
  }
}
