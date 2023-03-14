import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/my_page_data.dart';
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
