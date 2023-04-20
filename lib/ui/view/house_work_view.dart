import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/view/house_work_edit_index_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/house_work_view_controller.dart';
import '../widget/background.dart';
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
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HouseWorkEditIndexView(
                      categoryName: categoryName,
                      houseWorkCategoryId: houseWorkCategoryId,
                    ),
                    fullscreenDialog: true,
                  ),
                ),
                icon: const Icon(Icons.edit, size: 24),
              ))
        ],
      ),
      body: Background(
        child: GetLoadingStack<HouseWorkViewController>(
          child: _HouseWorks(houseWorkCategoryId: houseWorkCategoryId),
        ),
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

      return RefreshIndicator(
        color: primaryColor,
        onRefresh: controller.fetchData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                        onPressed: () => controller.onTapCompleteDialog(
                          houseWorkId: item.houseWorkId,
                          point: item.point,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
