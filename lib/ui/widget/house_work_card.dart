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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          splashFactory: InkRipple.splashFactory,
          elevation: 2,
          onPrimary: Colors.grey,
          primary: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
      ),
    );
  }
}
