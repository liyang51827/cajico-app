import 'package:cajico_app/ui/view/house_work_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/app_color.dart';

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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.28, // SEでも対応できるギリギリのサイズ
      child: ElevatedButton(
        onPressed: () => Get.to(HouseWorkView(categoryName: categoryName, imageUrl: imageUrl)),
        style: ElevatedButton.styleFrom(
          splashFactory: InkRipple.splashFactory,
          elevation: 2,
          foregroundColor: Colors.grey,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                categoryName,
                style: const TextStyle(
                    fontSize: 13,
                    color: gray2,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Image(
              image: AssetImage(imageUrl),
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
