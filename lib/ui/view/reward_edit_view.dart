import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/reward_edit_view_controller.dart';
import '../widget/normal_completed_dialog.dart';
import '../widget/normal_dialog.dart';
import '../widget/primary_button.dart';

class RewardEditView extends StatelessWidget {
  RewardEditView(
      {super.key,
      required this.rewardId,
      required this.rank,
      required this.initPoint,
      required this.initRewardName,
      required this.initMemo});

  final int rewardId;
  final String rank;
  final int initPoint;
  final String initRewardName;
  final String initMemo;
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RewardEditViewController());
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
              titleTextStyle: const TextStyle(fontSize: 22)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                verticalSpaceLarge,
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController.fromValue(
                    TextEditingValue(text: rank),
                  ),
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                      fillColor: gray8,
                      filled: true,
                      labelText: 'プラン',
                      labelStyle: const TextStyle(color: gray3),
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: gray4)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: gray4))),
                ),
                verticalSpaceMedium,
                TextFormField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(text: initRewardName),
                  ),
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                      labelText: 'ごほうび名',
                      labelStyle: const TextStyle(color: gray3),
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: gray4)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primaryColor))),
                  onChanged: (value) {
                    rewardName = value;
                  },
                ),
                verticalSpaceMedium,
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  controller: TextEditingController.fromValue(
                    TextEditingValue(text: initPoint.toString()),
                  ),
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                      labelText: '必要ポイント（100P~500P）',
                      suffixText: 'ポイント',
                      labelStyle: const TextStyle(color: gray3),
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: gray4)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primaryColor))),
                  onChanged: (value) {
                    point = int.parse(value);
                  },
                ),
                verticalSpaceMedium,
                TextFormField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(text: initMemo),
                  ),
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.multiline,
                  minLines: 10,
                  maxLines: 10,
                  decoration: InputDecoration(
                      labelText: 'ごほうびメモ',
                      labelStyle: const TextStyle(color: gray3),
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: gray4)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primaryColor))),
                  onChanged: (value) {
                    memo = value;
                  },
                ),
                verticalSpaceLarge,
                PrimaryButton(
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
                            builder: (context) => const NormalCompletedDialog(message: '更新されました'));
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
