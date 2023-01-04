import 'package:flutter/material.dart';
import '../common/app_color.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.imageUrl,
    required this.title,
    this.actions,
    this.bottom,
  });

  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black54),
      centerTitle: true,
      title: Row(children: [
        Image(
          image: AssetImage(imageUrl),
          height: 55,
        ),
        Text(title, style: const TextStyle(color: gray2)),
      ]),
      backgroundColor: Colors.white,
      titleTextStyle: const TextStyle(fontSize: 22),
      actions: actions,
      bottom: bottom,
    );
  }
}
