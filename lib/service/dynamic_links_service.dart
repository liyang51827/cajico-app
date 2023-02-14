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
    // const link = 'https://cajico.herokuapp.com/verify?type=new&token=7fe8ee11183678f9f3d57d325b7a53f970455aa47f5ba1820a4717a2ed1ea50a';
    // final deepLink = Uri.parse(link);
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
        await Future.delayed(const Duration(seconds: 5));
        unawaited(Get.to(() => RegisterFamilyView(type: type, token: token)));
        break;
    }
  }
}
