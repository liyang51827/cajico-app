import 'package:flutter/cupertino.dart';
import 'package:line_icons/line_icons.dart';

class NotificationAction extends StatelessWidget {
  const NotificationAction({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Icon(
        LineIcons.bell,
        size: 30,
      ),
    );
  }
}
