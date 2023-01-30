import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FileSelector {
  final double _maxHeight = 3000;
  final double _maxWidth = 3000;

  Future<File?> selectImage() async {
    final imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: _maxHeight,
      maxWidth: _maxWidth,
    );
    if (file == null) {
      return null;
    }
    return File(file.path);
  }
}
