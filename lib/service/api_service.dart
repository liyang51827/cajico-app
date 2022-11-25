import 'package:get/get.dart';
import '../model/house_works.dart';

class ApiService extends GetConnect {
  Future<List<HouseWorks>> getHouseWorksList() async {
    return [
      HouseWorks(
          categoryImageUrl: 'https://cazico-public.s3.ap-northeast-1.amazonaws.com/housework_image/1_cooking.png',
          name: '家事サンプルA',
          point: 100
      ),
      HouseWorks(
          categoryImageUrl: 'https://cazico-public.s3.ap-northeast-1.amazonaws.com/housework_image/1_cooking.png',
          name: '家事サンプルA',
          point: 100
      ),
      HouseWorks(
          categoryImageUrl: 'https://cazico-public.s3.ap-northeast-1.amazonaws.com/housework_image/1_cooking.png',
          name: '家事サンプルA',
          point: 100
      ),
      HouseWorks(
          categoryImageUrl: 'https://cazico-public.s3.ap-northeast-1.amazonaws.com/housework_image/1_cooking.png',
          name: '家事サンプルA',
          point: 100
      ),
      HouseWorks(
          categoryImageUrl: 'https://cazico-public.s3.ap-northeast-1.amazonaws.com/housework_image/1_cooking.png',
          name: '家事サンプルA',
          point: 100
      ),
      HouseWorks(
          categoryImageUrl: 'https://cazico-public.s3.ap-northeast-1.amazonaws.com/housework_image/1_cooking.png',
          name: '家事サンプルA',
          point: 100
      ),
    ];
  }
}
