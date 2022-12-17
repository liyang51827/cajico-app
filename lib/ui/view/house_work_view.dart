import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/house_work_view_controller.dart';
import '../widget/house_work_card.dart';
import '../widget/loading_stack.dart';

class HouseWorkView extends StatelessWidget {
  const HouseWorkView({
    super.key,
    required this.categoryName,
    required this.houseWorkCategoryId,
  });

  final String categoryName;
  final int houseWorkCategoryId;

  @override
  Widget build(BuildContext context) {
    Get.replace(HouseWorkViewController(houseWorkCategoryId: houseWorkCategoryId));
    return Scaffold(
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
                })
          ]),
      body: GetLoadingStack<HouseWorkViewController>(
        child: _HouseWorks(houseWorkCategoryId: houseWorkCategoryId)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _HouseWorks extends GetView<HouseWorkViewController> {
  const _HouseWorks({
    required this.houseWorkCategoryId
  });
  final int houseWorkCategoryId;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.put(HouseWorkViewController(houseWorkCategoryId: houseWorkCategoryId));

      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.houseWorks().length,
                itemBuilder: (context, index) {
                  final item = controller.houseWorks.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: HouseWorkCard(
                      houseWorkName: item.name,
                      imageUrl: item.categoryImageUrl,
                      point: item.point,
                      onPressed: () {
                          controller.onTapComplete(houseWorkId: item.houseWorkId);
                          Navigator.pop(context, true);
                        },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
