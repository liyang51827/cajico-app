import 'package:cajico_app/model/register_data.dart';
import 'package:cajico_app/ui/view/home_view.dart';
import 'package:cajico_app/ui/view/register_user_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/form_validation.dart';
import '../../util/form_validator.dart';
import 'base_view_controller.dart';
import 'dart:io';

class RegisterViewController extends BaseViewController {
  RegisterViewController();

  final newFamilyData = NewFamilyData(
    type: ''.obs,
    familyName: ''.obs,
    familyCode: ''.obs,
    userName: ''.obs,
    positionId: 0.obs,
    password: ''.obs,
    token: ''.obs,
    iconImage: Rxn<File>(),
  );

  FormValidation validateInputEditData({String? value, required maxLength}) =>
      FormValidator.validateEditBasicInfo(value: value, maxLength: maxLength);

  bool get isRegisterFamilyValid =>
      validateInputEditData(value: newFamilyData.familyName(), maxLength: 5).isValid;

  Future<void> onTapConfirmFamily() async {
    var result = false;
    await callAsyncApi(() async {
      if (newFamilyData.type() == 'new') {
        result = await api.confirmNewFamily(newFamilyData);
      } else if (newFamilyData.type() == 'join') {
        result = await api.confirmJoinFamily(newFamilyData);
      }
    });
    if (result) {
      Get.to(() => RegisterUserView());
    }
  }

  Future<void> onTapCreateUser() async {
    String? result = '';
    final prefs = await SharedPreferences.getInstance();
    await callAsyncApi(() async {
      if (newFamilyData.type() == 'new') {
        result = await api.createFamilyAndUser(newFamilyData);
      } else if (newFamilyData.type() == 'join') {
        result = await api.joinFamilyAndCreateUser(newFamilyData);
      }
    });
    if (result != '') {
      prefs.setString('token', result!);
      Get.to(() => const HomeView());
    }
  }

  Future<void> onTapSelectImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      newFamilyData.iconImage.value = File(pickedImage.path);
    }
  }
}
