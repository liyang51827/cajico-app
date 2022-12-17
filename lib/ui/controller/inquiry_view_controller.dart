import 'package:cajico_app/model/house_works.dart';
import 'package:get/get.dart';
import 'base_view_controller.dart';

class InquiryViewController extends BaseViewController {
  InquiryViewController();

  Future<void> onTapInquiry({required String title, required String body}) async {
    await callAsyncApi(() async {
      await api.postInquiry(title: title, body: body);
    });
  }
}
