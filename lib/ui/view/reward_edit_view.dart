import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/cajico_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/base_view_controller.dart';
import '../controller/home_view_controller.dart';
import '../controller/reward_edit_view_controller.dart';
import '../widget/normal_completed_dialog.dart';
import '../widget/normal_dialog.dart';
import '../widget/primary_button.dart';

class RewardEditView extends StatelessWidget {
  RewardEditView({
    super.key,
    required this.rewardId,
    required this.rank,
    required this.initPoint,
    required this.initRewardName,
    required this.initMemo,
  });

  final int rewardId;
  final String rank;
  final int initPoint;
  final String initRewardName;
  final String initMemo;
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RewardEditViewController());
    final homeController = Get.put(HomeViewController());
    final baseController = Get.put(BaseViewController());
    String rewardName = initRewardName;
    int point = initPoint;
    String memo = initMemo;

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
            titleTextStyle: const TextStyle(fontSize: 22),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                verticalSpaceLarge,
                CajicoTextFormField(
                  readOnly: true,
                  initValue: rank,
                  label: 'プラン',
                  filled: true,
                  fillColor: gray8,
                  focusedBorderColor: gray4,
                ),
                verticalSpaceMedium,
                CajicoTextFormField(
                  initValue: initRewardName,
                  label: 'ごほうび名',
                  onChanged: (value) => rewardName = value,
                ),
                verticalSpaceMedium,
                CajicoTextFormField(
                  initValue: initPoint.toString(),
                  label: '必要ポイント（100P~500P）',
                  suffixText: 'ポイント',
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) => point = int.parse(value),
                ),
                verticalSpaceMedium,
                CajicoTextFormField(
                  initValue: initMemo,
                  label: 'ごほうびメモ',
                  keyboardType: TextInputType.multiline,
                  minLines: 10,
                  maxLines: 10,
                  onChanged: (value) => memo = value,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              label: '変更する',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return NormalDialog(
                        message: '更新しますか？',
                        onPressed: () {
                          controller.onTapUpdate(
                              rewardId: rewardId,
                              rewardName: rewardName,
                              point: point,
                              memo: memo);
                          Navigator.pop(context, true);
                        },
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
            ),
          ),
        ),
      ),
    );
  }
}
