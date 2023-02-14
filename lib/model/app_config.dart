import 'package:firebase_core/firebase_core.dart';

import 'app_flavor.dart';

class AppConfig {
  AppConfig({
    required this.flavor,
    required this.androidPackageName,
    required this.iOSBundleId,
    required this.firebaseOptions,
    required this.domain,
    required this.dynamicLinkDomain,
  });

  final AppFlavor flavor;
  final String androidPackageName;
  final String iOSBundleId;
  final FirebaseOptions firebaseOptions;
  final String domain;
  final String dynamicLinkDomain;
}
