import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/cajico_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/base_view_controller.dart';
import '../controller/home_view_controller.dart';
import '../controller/house_work_edit_view_controller.dart';
import '../widget/normal_completed_dialog.dart';
import '../widget/normal_dialog.dart';
import '../widget/primary_button.dart';

class HouseWorkEditView extends StatelessWidget {
  HouseWorkEditView({super.key});

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HouseWorkEditViewController());
    final homeController = Get.put(HomeViewController());
    final baseController = Get.put(BaseViewController());

    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black54),
              centerTitle: true,
              title: const Text('ごほうびの編集', style: TextStyle(color: gray2)),
              backgroundColor: Colors.white,
              titleTextStyle: const TextStyle(fontSize: 22)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                verticalSpaceLarge,
                const CajicoTextFormField(
                  readOnly: true,
                  initValue: '料理',
                  label: '家事カテゴリー',
                  filled: true,
                  fillColor: gray8,
                  focusedBorderColor: gray4,
                ),
                verticalSpaceMedium,
                const CajicoTextFormField(
                    initValue: '朝ごはん準備',
                    label: '家事名'),
                verticalSpaceMedium,
                CajicoTextFormField(
                    initValue: 80.toString(),
                    label: '必要ポイント（100P~500P）',
                    suffixText: 'ポイント',
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]),
                verticalSpaceLarge,
                PrimaryButton(
                  label: '変更する',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return NormalDialog(
                            message: '更新しますか？',
                            onPressed: () {},
                          );
                        }).then((value) {
                      if (value) {
                        return showDialog(
                          context: context,
                          builder: (context) => NormalCompletedDialog(
                            message: '更新されました',
                            onPressed: () {
                              Navigator.pop(context);
                              homeController.onTapGetUnreadCount();
                              baseController.onTapBottomNavigation(0);
                            },
                          ),
                        );
                      }
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
