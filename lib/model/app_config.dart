import 'app_flavor.dart';

class AppConfig {
  AppConfig({
    required this.flavor,
    required this.androidPackageName,
    required this.iOSBundleId,
    required this.payJpPublicKey,
  });

  final AppFlavor flavor;
  final String androidPackageName;
  final String iOSBundleId;
  final String payJpPublicKey;
}
