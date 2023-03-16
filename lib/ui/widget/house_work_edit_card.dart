import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/view/house_work_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/app_color.dart';
import 'cajico_cashed_network_image.dart';

class HouseWorkEditCard extends StatelessWidget {
  const HouseWorkEditCard({
    super.key,
    required this.categoryId,
    required this.houseWorkId,
    required this.categoryName,
    required this.houseWorkName,
    required this.imageUrl,
    required this.point,
  });

  final int categoryId;
  final int houseWorkId;
  final String categoryName;
  final String houseWorkName;
  final String imageUrl;
  final int point;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
        onPressed: () => Get.to(
          () => HouseWorkEditView(
            categoryId: categoryId,
            houseWorkId: houseWorkId,
            categoryName: categoryName,
            initHouseWorkName: houseWorkName,
            initPoint: point,
          ),
        ),
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
        child: Container(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16),
                width: 100,
                child: CajicoCachedNetworkImage(imageUrl: imageUrl),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          houseWorkName,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    verticalSpaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          point.toString(),
                          style: TextStyle(
                            fontSize: 22,
                            color: point < 25 ? lowColor : point < 50 ? middleColor : point < 75 ? secondaryColor : point < 100 ? primaryColor : highestColor,
                          ),
                        ),
                        const Text(" ポイント", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
              horizontalSpaceLarge,
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: gray3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
