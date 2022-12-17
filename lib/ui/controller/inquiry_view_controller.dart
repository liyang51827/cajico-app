import 'package:cajico_app/model/house_works.dart';
import 'package:get/get.dart';
import 'base_view_controller.dart';

class InquiryViewController extends BaseViewController {
  InquiryViewController();

  Future<void> onTapInquiry() async {
    await callAsyncApi(() async {
      print('test');
      await api.postInquiry(title: 'test', body: 'test');
    });
  }
}
