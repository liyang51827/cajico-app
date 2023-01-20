import 'package:get/get.dart';
import '../../model/inquiry_data.dart';
import 'base_view_controller.dart';

class InquiryViewController extends BaseViewController {
  InquiryViewController();

  final inquiryData = InquiryData(
    title: ''.obs,
    body: ''.obs,
  );

  Future<void> onTapInquiry() async {
    await callAsyncApi(() async {
      await api.postInquiry(inquiryData);
    });
  }
}
