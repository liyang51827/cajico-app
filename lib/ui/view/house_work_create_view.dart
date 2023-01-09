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

class HouseWorkCreateView extends StatelessWidget {
  HouseWorkCreateView({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  final int categoryId;
  final String categoryName;
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HouseWorkEditViewController());
    final houseWorkController = Get.put(HouseWorkViewController(houseWorkCategoryId: categoryId));
    final homeController = Get.put(HomeViewController());
    String houseWorkName = '';
    int point = 0;

    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: const Text('家事の登録', style: TextStyle(color: gray2)),
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
                  initValue: '',
                  label: '家事名',
                  onChanged: (value) => houseWorkName = value,
                ),
                verticalSpaceMedium,
                CajicoTextFormField(
                  initValue: '',
                  label: '獲得ポイント',
                  suffixText: 'ポイント',
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) => point = int.parse(value),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              label: '登録する',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return NormalDialog(
                        message: '登録しますか？',
                        onPressed: () {
                          controller.onTapCreate(
                            houseWorkCategoryId: categoryId,
                            houseWorkName: houseWorkName,
                            point: point,
                          );
                          Navigator.pop(context, true);
                        },
                      );
                    }).then((value) {
                  if (value) {
                    return showDialog(
                      context: context,
                      builder: (context) => NormalCompletedDialog(
                        message: '登録されました',
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
            ),
          ),
        ),
      ),
    );
  }
}
