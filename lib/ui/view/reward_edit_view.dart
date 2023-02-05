import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/controller/reward_view_controller.dart';
import 'package:cajico_app/ui/widget/cajico_text_form_field.dart';
import 'package:cajico_app/ui/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
    required this.minPoint,
    required this.maxPoint,
  });

  final int minPoint;
  final int maxPoint;
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
    final rewardIndexController = Get.put(RewardViewController());
    final formatter = NumberFormat("#,###");
    final rewardInfo = controller.rewardData;
    rewardInfo.rewardId.value = rewardId;
    rewardInfo.rewardName.value = initRewardName;
    rewardInfo.point.value = initPoint;
    rewardInfo.memo.value = initMemo;
    rewardInfo.minPoint.value = minPoint;
    rewardInfo.maxPoint.value = maxPoint;

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
            backgroundColor: secondaryColor,
            titleTextStyle: const TextStyle(fontSize: 22),
          ),
          body: GetLoadingStack<RewardEditViewController>(
            child: SingleChildScrollView(
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
                    onChanged: (value) => rewardInfo.rewardName.value = value,
                    validator: (value) =>
                    controller
                        .validateInputEditData(value: value, maxLength: 10)
                        .message,
                  ),
                  verticalSpaceMedium,
                  CajicoTextFormField(
                    initValue: initPoint.toString(),
                    label: '必要ポイント（${formatter.format(minPoint)}P~${formatter.format(maxPoint)}P）',
                    suffixText: 'ポイント',
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) => rewardInfo.point.value = int.parse(value),
                    validator: (value) =>
                    controller
                        .validateInputPointData(value: value)
                        .message,
                  ),
                  verticalSpaceMedium,
                  CajicoTextFormField(
                    initValue: initMemo,
                    label: 'ごほうびメモ',
                    keyboardType: TextInputType.multiline,
                    minLines: 10,
                    maxLines: 10,
                    onChanged: (value) => rewardInfo.memo.value = value,
                    validator: (value) =>
                    controller
                        .validateInputEditData(value: value, maxLength: 500)
                        .message,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(
                  () =>
                  PrimaryButton(
                    label: '変更する',
                    isValid: controller.isUpdateButtonValid &&
                        (rewardInfo.rewardName() != initRewardName ||
                            rewardInfo.point() != initPoint ||
                            rewardInfo.memo() != initMemo),
                    onPressed: () {
                      Get.dialog(
                        NormalDialog(
                          message: '更新しますか？',
                          onPressed: () async {
                            Get.back();
                            await controller.onTapUpdate();
                            Get.dialog(
                              NormalCompletedDialog(
                                message: '更新されました',
                                onPressed: () {
                                  Get.back();
                                  homeController.onTapGetUnreadCount();
                                  baseController.onTapBottomNavigation(1);
                                  rewardIndexController.fetchData();
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
