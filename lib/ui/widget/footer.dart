import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LineIcons.gift),
            label: 'ごほうび',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.campground),
            label: '家事',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.history),
            label: '履歴',
          ),
        ],
        iconSize: 26,
        currentIndex: 1,
        selectedItemColor: Colors.amber[600],
      ),
    );
  }
}
