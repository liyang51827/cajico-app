import 'package:get/get.dart';
import '../../model/form_validation.dart';
import '../../model/my_page_data.dart';
import '../../util/form_validator.dart';
import 'base_view_controller.dart';

class MyPageEditViewController extends BaseViewController {
  MyPageEditViewController();

  final myPageData = MyPageData(
    familyName: ''.obs,
    familyCode: ''.obs,
    userName: ''.obs,
    position: ''.obs,
  );

  // FormValidation validateInputEditData({String? value, required maxLength}) =>
  //     FormValidator.validateEditBasicInfo(value: value, maxLength: maxLength);
  //
  // FormValidation validateInputPointData({String? value}) =>
  //     FormValidator.validateRequirePointRange(
  //       value: value, minPoint: myPageData.minPoint(), maxPoint: myPageData.maxPoint());
  //
  // bool get isUpdateButtonValid =>
  //     validateInputEditData(value: myPageData.rewardName(), maxLength: 10).isValid &&
  //         validateInputPointData(value: myPageData.point().toString()).isValid &&
  //         validateInputEditData(value: myPageData.memo(), maxLength: 100).isValid;
  //
  // Future<void> onTapUpdate() async {
  //   await callAsyncApi(() async {
  //     await api.putReward(myPageData);
  //   });
  // }
}
