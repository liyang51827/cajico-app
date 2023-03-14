import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/form_validation.dart';
import '../../model/my_page_data.dart';
import '../../util/form_validator.dart';
import 'base_view_controller.dart';
import 'dart:io';

class MyPageEditViewController extends BaseViewController {
  MyPageEditViewController();

  final myPageData = MyPageData(
    familyName: ''.obs,
    familyCode: ''.obs,
    userName: ''.obs,
    positionId: 0.obs,
    iconImage: Rxn<File>(),
  );

  FormValidation validateInputEditData({String? value, required maxLength}) =>
      FormValidator.validateEditBasicInfo(value: value, maxLength: maxLength);

  FormValidation validateInputPasswordData(
      {String? value, required minLength, required maxLength}) =>
      FormValidator.validateRequirePasswordRange(
          value: value, minLength: minLength, maxLength: maxLength);

  bool get isRegisterFamilyValid =>
      validateInputEditData(value: myPageData.familyName(), maxLength: 5).isValid &&
          validateInputPasswordData(value: myPageData.familyCode(), minLength: 8, maxLength: 20)
              .isValid;

  Future<void> onTapSelectImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 300.0,
      maxWidth: 300.0,
    );
    if (pickedImage != null) {
      myPageData.iconImage.value = File(pickedImage.path);
    }
  }
}
