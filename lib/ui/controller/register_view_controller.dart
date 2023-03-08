import 'package:cajico_app/model/register_data.dart';
import 'package:cajico_app/ui/view/register_user_view.dart';
import 'package:get/get.dart';
import '../../model/form_validation.dart';
import '../../util/form_validator.dart';
import 'base_view_controller.dart';

class RegisterViewController extends BaseViewController {
  RegisterViewController();

  final newFamilyData = NewFamilyData(
    familyName: ''.obs,
    familyCode: ''.obs,
    userName: ''.obs,
    positionId: 0.obs,
    birthday: ''.obs,
    password: ''.obs,
    token: ''.obs,
    deviceToken: ''.obs,
  );

  FormValidation validateInputEditData({String? value, required maxLength}) =>
      FormValidator.validateEditBasicInfo(value: value, maxLength: maxLength);

  bool get isRegisterFamilyValid =>
      validateInputEditData(value: newFamilyData.familyName(), maxLength: 5).isValid;

  Future<void> onTapConfirmNewFamily(
      {required type, required token, required familyName, required familyCode}) async {
    var result = false;
    await callAsyncApi(() async {
      result = await api.confirmNewFamily(
          type: type, token: token, familyName: familyName, familyCode: familyCode);
    });
    if (result) {
      Get.to(
        () => RegisterUserView(
            type: type, token: token, familyName: familyName, familyCode: familyCode),
      );
    }
  }
}
