import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:flutter/material.dart';

import '../common/app_color.dart';
import 'house_work_complete_dialog.dart';

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
      height: 100,
      child: ElevatedButton(
        onPressed: (){
          showDialog<void>(
              context: context,
              builder: (_) {
                return const HouseWorkCompleteDialog();
              });
        },
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Image(
                image: AssetImage(imageUrl),
                height: 70,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        categoryName,
                        style: const TextStyle(
                            fontSize: 18,
                            color: gray2
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
                            color: primaryColor
                        ),
                      ),
                      const Text(
                        " ポイント",
                        style: TextStyle(
                            fontSize: 18,
                            color: gray2
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
