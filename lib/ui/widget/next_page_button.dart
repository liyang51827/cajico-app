import 'package:flutter/material.dart';
import '../common/app_color.dart';

class NextPageButton extends StatelessWidget {
  const NextPageButton({
    super.key,
    required this.onPressed,
    this.label = '次の10件を表示',
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: gray4,
          shape: const StadiumBorder(),
          side: const BorderSide(color: gray4),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
