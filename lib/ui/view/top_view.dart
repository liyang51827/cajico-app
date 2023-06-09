import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/view/email_send_view.dart';
import 'package:cajico_app/ui/view/login_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/app_color.dart';
import '../controller/email_send_view_controller.dart';

final List<String> imgList = [
  'assets/images/introduction_1.png',
  'assets/images/introduction_2.png',
  'assets/images/introduction_3.png',
  'assets/images/introduction_4.png',
];

class TopView extends StatefulWidget {
  const TopView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<TopView> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final controller = Get.put(EmailSendViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CarouselSlider(
                items: const [
                  _CarouselCard(
                    title: 'CAJICO',
                    subtitle: '日々の「当たり前」を「ありがとう」に\nカジコで家事にやりがいを',
                    imageUrl: 'assets/images/introduction_1.png',
                  ),
                  _CarouselCard(
                    title: '家事ポイント',
                    subtitle: '家事をクリアしてポイントをゲット！\n家族で家事が「見える化」されます',
                    imageUrl: 'assets/images/introduction_2.png',
                  ),
                  _CarouselCard(
                    title: '家事履歴',
                    subtitle: 'これまでの家事は\n一覧でかんたんチェック！',
                    imageUrl: 'assets/images/introduction_4.png',
                  ),
                  _CarouselCard(
                    title: 'ごほうび',
                    subtitle: 'たまったポイントを使って\n家族にねぎらってもらおう！',
                    imageUrl: 'assets/images/introduction_3.png',
                  ),
                ],
                carouselController: _controller,
                options: CarouselOptions(
                    aspectRatio: 0.85,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 500),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 8.0,
                      height: 6.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
              const _AuthSection(),
            ],
          ),
        ),
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
    return Column(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            title,
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black87, letterSpacing: 3),
            textAlign: TextAlign.center,
          ),
        ),
        verticalSpaceMedium,
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87, letterSpacing: 1),
        ),
        verticalSpaceMedium,
        Image(image: AssetImage(imageUrl)),
      ],
    );
  }
}

class _AuthSection extends StatelessWidget {
  const _AuthSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
              onPressed: () => Get.to(() => EmailSendView(type: 'new')),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.home),
                  horizontalSpaceSmall,
                  Text(
                    'CAJICOを始める',
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
              onPressed: () => Get.to(() => EmailSendView(type: 'join')),
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
          verticalSpaceMediumLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'カジコをご利用中の方は',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InkWell(
                child: const Text(
                  'こちら',
                  style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                ),
                onTap: () => Get.to(() => LoginView()),
              ),
            ],
          ),
          verticalSpaceSmall,
        ],
      ),
    );
  }
}
