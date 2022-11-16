import 'package:flutter/material.dart';

class RewardCategoryCard extends StatelessWidget {
  const RewardCategoryCard({
    super.key,
    required this.categoryName,
    required this.imageUrl,
  });

  final String categoryName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(
            Colors.black26,
            BlendMode.srcATop,
          ), //
        )
      ),
    );
  }
}
