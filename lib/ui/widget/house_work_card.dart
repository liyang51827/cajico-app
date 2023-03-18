import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/widget/primary_small_button.dart';
import 'package:cajico_app/ui/widget/primary_small_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/app_color.dart';
import 'cajico_cashed_network_image.dart';

class HouseWorkCard extends StatelessWidget {
  const HouseWorkCard({
    super.key,
    required this.houseWorkName,
    required this.imageUrl,
    required this.point,
    required this.onPressed,
  });

  final String houseWorkName;
  final String imageUrl;
  final int point;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          Get.dialog(
            _HouseWorkCompleteDialog(
              houseWorkName: houseWorkName,
              point: point,
              onPressed: onPressed,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          splashFactory: InkRipple.splashFactory,
          elevation: 3,
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
                          style: TextStyle(
                            fontSize: 22,
                            color: point < 25
                                ? lowColor
                                : point < 50
                                    ? middleColor
                                    : point < 75
                                        ? secondaryColor
                                        : point < 100
                                            ? primaryColor
                                            : highestColor,
                          ),
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

class _HouseWorkCompleteDialog extends StatelessWidget {
  const _HouseWorkCompleteDialog({
    required this.houseWorkName,
    required this.point,
    required this.onPressed,
  });

  final String houseWorkName;
  final int point;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Column(
        children: [
          Text(houseWorkName, style: const TextStyle(fontWeight: FontWeight.bold)),
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(point.toString(),
                  style: TextStyle(
                    color: point < 25 ? lowColor : point < 50 ? middleColor : point < 75 ? secondaryColor : point < 100 ? primaryColor : highestColor,
                    fontSize: 24,
                  )),
              const Text(' ポイント', style: TextStyle(fontSize: 16))
            ],
          ),
          verticalSpaceMedium,
          const Text('この家事をクリアした？', style: TextStyle(fontSize: 16))
        ],
      ),
      children: [
        SimpleDialogOption(
          onPressed: onPressed,
          child: const PrimarySmallButton(text: 'はい！'),
        ),
        SimpleDialogOption(
          child: const PrimarySmallOutlineButton(text: 'いいえ'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        )
      ],
    );
  }
}
