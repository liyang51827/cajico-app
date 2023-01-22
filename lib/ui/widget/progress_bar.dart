import 'package:badges/badges.dart';
import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import '../common/ui_helper.dart';
import '../controller/home_view_controller.dart';
import '../view/notification_view.dart';

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
