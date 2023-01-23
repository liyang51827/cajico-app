import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import '../common/ui_helper.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.step});

  final int step;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(color: primaryColor, height: 5)),
        horizontalSpaceSmall,
        Expanded(child: Container(color: step >= 2 ? primaryColor : gray5, height: 5)),
        horizontalSpaceSmall,
        Expanded(child: Container(color: step >= 3 ? primaryColor : gray5, height: 5)),
      ],
    );
  }
}
