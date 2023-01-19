import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_strings.dart';
import '../common/ui_helper.dart';
import 'primary_button.dart';

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

class DefaultRichDialog extends StatelessWidget {
  const DefaultRichDialog({
    super.key,
    this.title,
    this.positiveLabel = Strings.ok,
    this.negativeLabel = Strings.cancel,
    this.onPositive,
    this.onNegative,
  });

  final String? title;
  final String positiveLabel;
  final String negativeLabel;
  final VoidCallback? onPositive;
  final VoidCallback? onNegative;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            verticalSpaceSmall,
            title != null
                ? Text(
                    title!,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  )
                : const SizedBox(),
            verticalSpaceLarge,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  PrimaryButton(
                    label: positiveLabel,
                    onPressed: () {
                      onPositive?.call();
                      Get.back();
                    },
                  ),
                  verticalSpaceMedium,
                  SubButton(
                    label: negativeLabel,
                    onPressed: () {
                      onNegative?.call();
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
