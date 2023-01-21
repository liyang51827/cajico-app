import 'package:get/get.dart';
import '../../model/form_validation.dart';
import '../../model/reward_data.dart';
import '../../util/form_validator.dart';
import 'base_view_controller.dart';

class RewardEditViewController extends BaseViewController {
  RewardEditViewController();

  final rewardData = RewardData(
    rewardId: 0.obs,
    rewardName: ''.obs,
    point: 0.obs,
    memo: ''.obs,
  );

  FormValidation validateInputEditData({String? value, required maxLength}) =>
      FormValidator.validateEditBasicInfo(value: value, maxLength: maxLength);

  FormValidation validateInputPointData({String? value, required maxLength}) =>
      FormValidator.validateRequirePoint(value: value, maxLength: maxLength);

  bool get isUpdateButtonValid =>
      validateInputEditData(value: rewardData.rewardName(), maxLength: 10).isValid &&
          validateInputPointData(value: rewardData.point().toString(), maxLength: 4).isValid &&
          validateInputEditData(value: rewardData.memo(), maxLength: 100).isValid;

  Future<void> onTapUpdate() async {
    await callAsyncApi(() async {
      await api.putReward(rewardData);
    });
  }
}
