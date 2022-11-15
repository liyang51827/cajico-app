import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:flutter/material.dart';

class HouseWorkCard extends StatelessWidget {
  const HouseWorkCard({
    super.key,
    required this.categoryName,
    required this.imageUrl,
    required this.point,
  });

  final String categoryName;
  final String imageUrl;
  final int point;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image(
            image: AssetImage(imageUrl),
            height: 70,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      categoryName,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87
                      ),
                    ),
                  ],
                ),
                verticalSpaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      point.toString(),
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black87
                      ),
                    ),
                    const Text(
                      " ポイント",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
