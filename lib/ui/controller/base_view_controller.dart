import 'dart:async';
import 'package:cajico_app/ui/view/history_view.dart';
import 'package:cajico_app/ui/view/home_view.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../constant/app_strings.dart';
import '../../model/app_config.dart';
import '../../model/app_flavor.dart';
import '../../model/loading_state.dart';
import '../view/reward_view.dart';
import '../widget/common_dialog.dart';

class BaseViewController extends GetxController {
  final RxInt tabIndex = 1.obs;
  Rx<LoadingState> loadingState = Rx<LoadingState>(LoadingSuccess());

  void onTapBottomNavigation(int index) {
    if (index == 0) {
      tabIndex.value = 0;
      Get.to(const HouseWork());
    } else if (index == 1) {
      tabIndex.value = 1;
      Get.to(const RewardView());
    } else if (index == 2) {
      tabIndex.value = 2;
      Get.to(const HistoryView());
    }
  }

  Future<void> callAsyncApi(
    AsyncCallback callback, {
    Function(Exception)? onException,
    bool useLoadingState = true,
  }) async {
    if (useLoadingState) {
      loadingState.value = LoadingInProgress();
    }
    try {
      await callback();
      if (useLoadingState) {
        loadingState.value = LoadingSuccess();
      }
    } on CheckedFromJsonException catch (e) {
      Get.log(e.toString());
      if (useLoadingState) {
        loadingState.value = LoadingFailure();
      }
      final content = (Get.find<AppConfig>().flavor != AppFlavor.production)
          ? Strings.parseError
          : Strings.apiError;
      unawaited(Get.dialog(
        DefaultAlertDialog(
          description: content,
        ),
      ));
    } on Exception catch (e) {
      Get.log(e.toString());
      if (useLoadingState) {
        loadingState.value = LoadingFailure();
      }
      if (onException == null) {
        unawaited(Get.dialog(
          const DefaultAlertDialog(
            description: Strings.apiError,
          ),
        ));
      } else {
        onException(e);
      }
    }
  }
}
