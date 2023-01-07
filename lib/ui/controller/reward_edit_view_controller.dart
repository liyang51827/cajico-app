import 'package:cajico_app/model/reward_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'base_view_controller.dart';

enum FormStatus { idle, loading, error, success }

class RewardEditViewController extends BaseViewController {
  RewardEditViewController();
  final rewardName = ''.obs;
  final point = 0.obs;
  final memo = ''.obs;

  Future<void> onTapUpdate({required String title, required String body}) async {
    await callAsyncApi(() async {
      await api.postInquiry(title: title, body: body);
    });
  }
}
