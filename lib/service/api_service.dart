import 'package:get/get.dart';
import '../model/covid_api_model.dart';

class ApiService extends GetConnect {
  // Get request
  Future<Response<CovidApiModel>> getAddress() => get(
    'https://api.covid19api.com/',
    decoder: CovidApiModel.fromJson,
  );
}
