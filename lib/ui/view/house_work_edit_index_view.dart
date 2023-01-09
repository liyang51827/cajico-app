import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/view/house_work_create_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/house_work_view_controller.dart';
import '../widget/house_work_edit_card.dart';
import '../widget/loading_stack.dart';

class HouseWorkEditIndexView extends StatelessWidget {
  const HouseWorkEditIndexView({
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
        title: Text('$categoryNameの編集', style: const TextStyle(color: gray2)),
        backgroundColor: secondaryColor,
        titleTextStyle: const TextStyle(fontSize: 22),
      ),
      body: GetLoadingStack<HouseWorkViewController>(
          child: _HouseWorks(houseWorkCategoryId: houseWorkCategoryId)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(
          HouseWorkCreateView(categoryId: houseWorkCategoryId, categoryName: categoryName),
        ),
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _HouseWorks extends GetView<HouseWorkViewController> {
  const _HouseWorks({required this.houseWorkCategoryId});

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
                    child: HouseWorkEditCard(
                      categoryId: houseWorkCategoryId,
                      houseWorkId: item.houseWorkId,
                      houseWorkName: item.name,
                      categoryName: item.categoryName,
                      imageUrl: item.categoryImageUrl,
                      point: item.point,
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
