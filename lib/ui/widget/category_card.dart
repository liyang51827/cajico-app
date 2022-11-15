import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categoryName,
    required this.imageUrl,
  });

  final String categoryName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      width: MediaQuery.of(context).size.width * 0.28, // SEでも対応できるギリギリのサイズ
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            categoryName,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black87
            ),
          ),
          Image(
            image: AssetImage(imageUrl),
            height: 70,
          ),
        ],
      ),
    );
  }
}
