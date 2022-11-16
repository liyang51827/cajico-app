import 'package:cajico_app/service/api_service.dart';
import 'package:get/get.dart';
import 'model/app_config.dart';

void setupLocator(AppConfig config) {
  Get
    ..lazyPut(() => config)
    ..lazyPut(ApiService.new);
}
