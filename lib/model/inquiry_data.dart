import 'package:get/get_rx/src/rx_types/rx_types.dart';

class InquiryData {
  InquiryData({
    required this.title,
    required this.body,
  });

  final RxString title;
  final RxString body;
}
