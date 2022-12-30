import 'package:cajico_app/ui/view/house_work_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/app_color.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categoryName,
    required this.imageUrl,
    required this.houseWorkCategoryId,
  });

  final String categoryName;
  final String imageUrl;
  final int houseWorkCategoryId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.28, // SEでも対応できるギリギリのサイズ
      child: ElevatedButton(
        onPressed: () => Get.to(() =>
            HouseWorkView(categoryName: categoryName, houseWorkCategoryId: houseWorkCategoryId)),
        style: ElevatedButton.styleFrom(
          splashFactory: InkRipple.splashFactory,
          elevation: 2,
          foregroundColor: gray2,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: const BorderSide(
            color: gray6,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                categoryName,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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
