import 'package:cajico_app/model/register_data.dart';
import 'package:cajico_app/ui/view/register_user_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/form_validation.dart';
import '../../util/form_validator.dart';
import 'base_view_controller.dart';
import 'dart:io';

class RegisterViewController extends BaseViewController {
  RegisterViewController();

  final newFamilyData = NewFamilyData(
    familyName: ''.obs,
    familyCode: ''.obs,
    userName: ''.obs,
    positionId: 0.obs,
    password: ''.obs,
    token: ''.obs,
    deviceToken: ''.obs,
    iconImage: Rxn<File>(),
  );

  FormValidation validateInputEditData({String? value, required maxLength}) =>
      FormValidator.validateEditBasicInfo(value: value, maxLength: maxLength);

  bool get isRegisterFamilyValid =>
      validateInputEditData(value: newFamilyData.familyName(), maxLength: 5).isValid;

  Future<void> onTapConfirmFamily(
      {required type, required token, required familyName, required familyCode}) async {
    var result = false;
    await callAsyncApi(() async {
      if (type == 'new') {
        result = await api.confirmNewFamily(
            type: type, token: token, familyName: familyName, familyCode: familyCode);
      } else if (type == 'join') {
        result = await api.confirmJoinFamily(
            type: type, token: token, familyName: familyName, familyCode: familyCode);
      }
    });
    if (result) {
      newFamilyData.token.value = token;
      newFamilyData.familyName.value = familyName;
      newFamilyData.familyCode.value = familyCode;
      Get.to(() => RegisterUserView(type: type));
    }
  }

  Future<void> onTapSelectImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      newFamilyData.iconImage.value = File(pickedImage.path);
    }
  }
}
