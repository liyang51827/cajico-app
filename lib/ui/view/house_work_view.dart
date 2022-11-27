import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../common/ui_helper.dart';
import '../widget/house_work_card.dart';

class HouseWorkView extends StatelessWidget {
  const HouseWorkView({
    super.key,
    required this.categoryName,
    required this.imageUrl,
  });
  final String categoryName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: gray7,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black54),
          centerTitle: true,
          title: Text(categoryName, style: const TextStyle(color: gray2)),
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(fontSize: 22),
          actions: <Widget>[
            PopupMenuButton(
              offset: const Offset(0, 50),
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(child: Text('編集する')),
                ];
              }
            )
          ]
        ),
        body: SingleChildScrollView (
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                verticalSpaceMedium,
                HouseWorkCard(
                  houseWorkName: 'サンプル家事A',
                  imageUrl: imageUrl,
                  point: 50,
                ),
                verticalSpaceSmall,
                HouseWorkCard(
                  houseWorkName: 'サンプル家事B',
                  imageUrl: imageUrl,
                  point: 50,
                ),
                verticalSpaceSmall,
                HouseWorkCard(
                  houseWorkName: 'サンプル家事C',
                  imageUrl: imageUrl,
                  point: 50,
                ),
                verticalSpaceSmall,
                HouseWorkCard(
                  houseWorkName: 'サンプル家事D',
                  imageUrl: imageUrl,
                  point: 50,
                ),
                verticalSpaceSmall,
                HouseWorkCard(
                  houseWorkName: 'サンプル家事E',
                  imageUrl: imageUrl,
                  point: 50,
                ),
                verticalSpaceSmall,
                HouseWorkCard(
                  houseWorkName: 'サンプル家事F',
                  imageUrl: imageUrl,
                  point: 50,
                ),
                verticalSpaceSmall,
                HouseWorkCard(
                  houseWorkName: 'サンプル家事G',
                  imageUrl: imageUrl,
                  point: 50,
                ),
                verticalSpaceSmall,
                HouseWorkCard(
                  houseWorkName: 'サンプル家事H',
                  imageUrl: imageUrl,
                  point: 50,
                ),
                verticalSpaceSmall,
                HouseWorkCard(
                  houseWorkName: 'サンプル家事I',
                  imageUrl: imageUrl,
                  point: 50,
                ),
                verticalSpaceSmall,
                HouseWorkCard(
                  houseWorkName: 'サンプル家事J',
                  imageUrl: imageUrl,
                  point: 50,
                ),
                verticalSpaceSmall,
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: primaryColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
