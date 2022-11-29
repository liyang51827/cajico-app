import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../common/app_color.dart';

class HouseWorkGrayButton extends StatelessWidget {
  const HouseWorkGrayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.only(top: 40),
      child: FloatingActionButton(
        elevation: 0.0,
        backgroundColor: primaryColor,
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(LineIcons.home),
            Text('家事'),
          ],
        ),
      ),
    );
  }
}
