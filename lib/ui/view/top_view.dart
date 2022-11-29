import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/view/home_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/app_color.dart';

class TopView extends StatelessWidget {
  const TopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            _CarouselSection(),
            _AuthSection(),
          ],
        ),
      ),
    );
  }
}

class _CarouselSection extends StatelessWidget {
  const _CarouselSection();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: const [
        _CarouselCard(
            title: 'CAJICO',
            subtitle: 'カジコは家族の家事を「見える化」する\n家事管理アプリです',
            imageUrl: 'assets/images/introduction_1.png'),
        _CarouselCard(
            title: '家事ポイント',
            subtitle: '家事をクリアして\nポイントをゲット！',
            imageUrl: 'assets/images/introduction_2.png'),
        _CarouselCard(
            title: 'ごほうび',
            subtitle: 'たまったポイントで\n家族にねぎらってもらおう！',
            imageUrl: 'assets/images/introduction_3.png'),
      ],
      options: CarouselOptions(
        aspectRatio: 0.95,
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        autoPlayCurve: Curves.fastOutSlowIn,
        viewportFraction: 1,
      ),
    );
  }
}

class _CarouselCard extends StatelessWidget {
  const _CarouselCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  final String title;
  final String subtitle;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 50,
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ),
      verticalSpaceMedium,
      Text(
        subtitle,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      verticalSpaceMedium,
      Image(image: AssetImage(imageUrl)),
    ]);
  }
}

class _AuthSection extends StatelessWidget {
  const _AuthSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                elevation: 0,
              ),
              onPressed: () => Get.to(() => const HouseWork()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.family_restroom),
                  horizontalSpaceSmall,
                  Text(
                    '家族に参加する',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          verticalSpaceMedium,
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: primaryColor,
                shape: const StadiumBorder(),
                side: const BorderSide(color: primaryColor),
                elevation: 0,
              ),
              onPressed: () => Get.to(() => const HouseWork()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add_home),
                  horizontalSpaceSmall,
                  Text(
                    '新しく家族を登録',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          verticalSpaceLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'カジコをご利用中の方は',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'こちら',
                style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
