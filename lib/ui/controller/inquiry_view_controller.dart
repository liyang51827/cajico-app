import 'package:get/get.dart';
import '../../model/form_validation.dart';
import '../../model/inquiry_data.dart';
import '../../util/form_validator.dart';
import 'base_view_controller.dart';

class InquiryViewController extends BaseViewController {
  InquiryViewController();

  final inquiryData = InquiryData(
    title: ''.obs,
    body: ''.obs,
  );

  FormValidation validateInputEditData(String? value) =>
      FormValidator.validateEditBasicInfo(value: value, maxLength: 20);

  Future<void> onTapInquiry() async {
    await callAsyncApi(() async {
      await api.postInquiry(inquiryData);
    });
  }
}
