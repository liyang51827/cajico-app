import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

import '../ui/view/register_family_view.dart';

mixin DeepLinkMixin<T extends StatefulWidget> on State<T> {
  StreamSubscription? _sub;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> init() async {
    /// DeepLinkを監視する
    await getInitialLink();
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _checkDeepLink(uri);
      }
    });
  }

  Future<void> _checkDeepLink(Uri? deepLink) async {
    print('object3');
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
