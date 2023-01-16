import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/cajico_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/home_view_controller.dart';
import '../controller/house_work_edit_view_controller.dart';
import '../controller/house_work_view_controller.dart';
import '../widget/normal_completed_dialog.dart';
import '../widget/normal_dialog.dart';
import '../widget/primary_button.dart';

class HouseWorkEditView extends StatelessWidget {
  HouseWorkEditView({
    super.key,
    required this.categoryId,
    required this.houseWorkId,
    required this.categoryName,
    required this.initHouseWorkName,
    required this.initPoint,
  });

  final int categoryId;
  final int houseWorkId;
  final int initPoint;
  final String categoryName;
  final String initHouseWorkName;
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HouseWorkEditViewController());
    String houseWorkName = initHouseWorkName;
    int point = initPoint;

    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: const Text('家事の編集', style: TextStyle(color: gray2)),
            backgroundColor: secondaryColor,
            titleTextStyle: const TextStyle(fontSize: 22),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                verticalSpaceLarge,
                CajicoTextFormField(
                  readOnly: true,
                  initValue: categoryName,
                  label: '家事カテゴリー',
                  filled: true,
                  fillColor: gray8,
                  focusedBorderColor: gray4,
                ),
                verticalSpaceMedium,
                CajicoTextFormField(
                  initValue: houseWorkName,
                  label: '家事名',
                  onChanged: (value) => houseWorkName = value,
                ),
                verticalSpaceMedium,
                CajicoTextFormField(
                  initValue: point.toString(),
                  label: '獲得ポイント',
                  suffixText: 'ポイント',
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) => point = int.parse(value),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 160,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                PrimaryButton(
                  label: '変更する',
                  onPressed: () => controller.onTapUpdateDialog(
                    houseWorkCategoryId: categoryId,
                    houseWorkId: houseWorkId,
                    houseWorkName: houseWorkName,
                    point: point,
                  ),
                ),
                verticalSpaceMedium,
                _DeleteBottom(categoryId: categoryId, houseWorkId: houseWorkId)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DeleteBottom extends StatelessWidget {
  const _DeleteBottom({
    required this.categoryId,
    required this.houseWorkId,
  });

  final int categoryId;
  final int houseWorkId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HouseWorkEditViewController());
    final houseWorkController = Get.put(HouseWorkViewController(houseWorkCategoryId: categoryId));
    final homeController = Get.put(HomeViewController());

    return PrimaryOutlineButton(
      label: '削除する',
      onPressed: () {
        Get.dialog(
          NormalDialog(
            message: '削除しますか？',
            onPressed: () {
              controller.onTapDelete(houseWorkId: houseWorkId);
              Navigator.pop(context, true);
            },
          ),
        ).then((value) {
          if (value) {
            return Get.dialog(
              NormalCompletedDialog(
                message: '削除されました',
                onPressed: () {
                  Navigator.pop(context);
                  homeController.onTapGetUnreadCount();
                  Navigator.pop(context);
                  houseWorkController.fetchData();
                },
              ),
            );
          }
        });
      },
    );
  }
}
