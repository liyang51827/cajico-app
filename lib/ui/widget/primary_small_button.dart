import 'package:flutter/material.dart';
import '../common/app_color.dart';

class PrimarySmallButton extends StatelessWidget {
  const PrimarySmallButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(20)),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ));
  }
}
