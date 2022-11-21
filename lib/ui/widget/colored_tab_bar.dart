import 'package:flutter/material.dart';

class ColoredTabBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget tabBar;
  final Color color;

  // コンストラクタでchildとなる[TabBar]と背景色を指定
  const ColoredTabBar({super.key, required this.tabBar, required this.color});

  @override
  Widget build(BuildContext context) {
    // [Ink]でwrapして背景色を指定
    return Ink(
      color: color,
      child: tabBar,
    );
  }

  // [AppBar]のbottomに指定するためには[PreferredSizeWidget]である必要があり、そのためにこのmethodをoverrideします。
  // 実態はchildである[TabBar]のpreferredSizeをそのまま使えばOK
  @override
  Size get preferredSize => tabBar.preferredSize;
}
