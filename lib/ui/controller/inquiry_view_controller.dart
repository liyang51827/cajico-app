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

  FormValidation validateInputEditData({String? value, required maxLength}) =>
      FormValidator.validateEditBasicInfo(value: value, maxLength: maxLength);

  bool get isInquiryButtonValid =>
      validateInputEditData(value: inquiryData.title(), maxLength: 20).isValid &&
      validateInputEditData(value: inquiryData.body(), maxLength: 500).isValid;

  Future<void> onTapInquiry() async {
    await callAsyncApi(() async {
      await api.postInquiry(inquiryData);
    });
  }
}
