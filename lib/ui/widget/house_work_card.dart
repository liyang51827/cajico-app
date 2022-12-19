import 'package:cached_network_image/cached_network_image.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:flutter/material.dart';

import '../common/app_color.dart';
import 'house_work_complete_dialog.dart';
import 'house_work_completed_dialog.dart';

class HouseWorkCard extends StatelessWidget {
  const HouseWorkCard(
      {super.key,
      required this.houseWorkName,
      required this.imageUrl,
      required this.point,
      required this.onPressed});

  final String houseWorkName;
  final String imageUrl;
  final int point;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return HouseWorkCompleteDialog(
                  houseWorkName: houseWorkName,
                  point: point,
                  onPressed: onPressed,
                );
              }).then((value) {
            if (value) {
              return showDialog(
                  context: context, builder: (context) => HouseWorkCompletedDialog(point: point));
            }
          });
        },
        style: ElevatedButton.styleFrom(
          splashFactory: InkRipple.splashFactory,
          elevation: 2,
          foregroundColor: gray2,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
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
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
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
                        Text(houseWorkName,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    verticalSpaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          point.toString(),
                          style: const TextStyle(fontSize: 22, color: primaryColor),
                        ),
                        const Text(" ポイント", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
