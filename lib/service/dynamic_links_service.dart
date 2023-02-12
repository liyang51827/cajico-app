import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

import '../ui/view/register_family_view.dart';

class DynamicLinksService extends GetxService {

  Future<DynamicLinksService> init() async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinks) {
      _checkDeepLink(dynamicLinks.link);
    });
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    unawaited(_checkDeepLink(data?.link));
    return this;
  }

  Future<void> _checkDeepLink(Uri? deepLink) async {
    if (deepLink == null) {
      return;
    }
    final mode = deepLink.queryParameters['mode'];
    final actionCode = deepLink.queryParameters['oobCode'];
    if (actionCode == null) {
      return;
    }
    switch (mode) {
      case 'verifyEmail':
          unawaited(Get.to(RegisterFamilyView()));
        break;
    }
  }
}
