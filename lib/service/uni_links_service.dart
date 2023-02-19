import 'dart:async';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

import '../ui/view/register_family_view.dart';

class UniLinksService extends GetxService {
  Future<UniLinksService> init() async {
    uriLinkStream.listen((Uri? link) {
      _checkDeepLink(link);
    });
    return this;
  }

  Future<void> _checkDeepLink(Uri? deepLink) async {
    if (deepLink == null) {
      return;
    }
    final type = deepLink.queryParameters['type'];
    final token = deepLink.queryParameters['token'];
    if (type == null || token == null) {
      return;
    }
    switch (type) {
      case 'new':
      case 'join':
        unawaited(Get.to(() => RegisterFamilyView(type: type, token: token)));
        break;
    }
  }
}
