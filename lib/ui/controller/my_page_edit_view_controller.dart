import 'package:get/get.dart';
import '../../model/my_page_data.dart';
import 'base_view_controller.dart';

class MyPageEditViewController extends BaseViewController {
  MyPageEditViewController();

  final myPageData = MyPageData(
    familyName: ''.obs,
    familyCode: ''.obs,
    userName: ''.obs,
    position: ''.obs,
  );
}
