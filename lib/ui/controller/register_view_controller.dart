import 'package:cajico_app/model/register_data.dart';
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
}
