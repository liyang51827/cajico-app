import 'dart:convert';
import 'package:get/get.dart';
import '../model/point_history.dart';
import '../model/house_works.dart';
import 'package:http/http.dart' as http;
import '../model/notice.dart';
import '../model/family_reward.dart';
import '../model/reward_history.dart';

class ApiService extends GetConnect {
  String? token;
  static const _commonHeaders = {
    'content-type': 'application/json',
  };

  Uri _makeUri(String path, {Map<String, String?>? queryParams}) {
    final apiPath = "/api$path";
    return Uri.https('cajico.herokuapp.com', apiPath, queryParams);
  }

  bool _checkStatusCode(http.Response response) {
    final statusCode = response.statusCode;
    if (statusCode >= 200 && statusCode < 300) {
      return true;
    } else if (statusCode == 404) {
      throw ApiException('データがありません');
    } else if (statusCode == 401) {
      final body = json.decode(response.body);
      throw ApiException(body['errorMessage'] ?? '認証できませんでした');
    } else if (statusCode == 422) {
      final body = json.decode(response.body);
      throw ApiException(body['errorMessage'] ?? 'エラーが発生しました');
    } else {
      throw ApiException('エラーが発生しました');
    }
  }

  Future<Map<String, String>> makeAuthorizationBearerHeader() async {
    const token = '1|mkwpdINcP5sDsIrg23g46RjgndoD0WMy3R4kZrDn';
    return {
      'Authorization': "Bearer $token",
    };
  }

  // // SharedPreferencesからトークンを取得
  // _setToken() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   String? localToken = localStorage.getString('token');
  //
  //   // なぜかlocalStorageから取得した値の前後に"が入るので仕方なくここで置換する
  //   if (localToken != null) {
  //     token = localToken.replaceAll('"', '');
  //   }
  // }

  Map<String, dynamic> _decodeResponse<T>(http.Response response) {
    _checkStatusCode(response);
    return json.decode(response.body);
  }

  Future<Map<String, String>> _makeAuthenticatedHeader() async {
    return {}
      ..addAll(_commonHeaders)
      ..addAll(await makeAuthorizationBearerHeader());
  }

  // ログインAPI
  Future<String?> login({required String email, required String password}) async {
    final res = await http.post(
      _makeUri('/login'),
      headers: _commonHeaders,
      body: jsonEncode({'email': email, 'password': password}),
    );
    final String? token = _decodeResponse(res)['data']['accessToken'];
    return token;
  }

  // 最近の家事取得API
  Future<List<HouseWork>> getRecentHouseWorksList() async {
    final res = await http.get(
      _makeUri('/house-works-recently'),
      headers: await _makeAuthenticatedHeader(),
    );
    final List<dynamic> data = _decodeResponse(res)['data'];
    return data.map((json) => HouseWork.fromJson(json)).toList();
  }

  // カテゴリ毎の家事一覧取得API
  Future<List<HouseWork>> getHouseWorksList({required int houseWorkCategoryId}) async {
    final res = await http.get(
      _makeUri('/house-works',
          queryParams: {'houseWorkCategoryId': houseWorkCategoryId.toString()}),
      headers: await _makeAuthenticatedHeader(),
    );
    final List<dynamic> data = _decodeResponse(res)['data'];
    return data.map((json) => HouseWork.fromJson(json)).toList();
  }

  // 家事完了API
  Future<bool> postCompleteHouseWork({required int houseWorkId}) async {
    final res = await http.post(
      _makeUri('/house-works/$houseWorkId/complete'),
      headers: await _makeAuthenticatedHeader(),
    );
    return _checkStatusCode(res);
  }

  // お知らせ一覧API
  Future<List<Notice>> getNoticesList() async {
    final res = await http.get(
      _makeUri('/notices'),
      headers: await _makeAuthenticatedHeader(),
    );
    final List<dynamic> data = _decodeResponse(res)['data'];
    return data.map((json) => Notice.fromJson(json)).toList();
  }

  // ごほうび一覧API
  Future<List<FamilyReward>> getFamilyRewardList() async {
    final res = await http.get(
      _makeUri('/rewards'),
      headers: await _makeAuthenticatedHeader(),
    );
    final List<dynamic> data = _decodeResponse(res)['data'];
    return data.map((json) => FamilyReward.fromJson(json)).toList();
  }

  // 家事履歴一覧API
  Future<List<PointHistory>> getPointHistoryList() async {
    final res = await http.get(
      _makeUri('/point-histories'),
      headers: await _makeAuthenticatedHeader(),
    );
    final List<dynamic> data = _decodeResponse(res)['data'];
    return data.map((json) => PointHistory.fromJson(json)).toList();
  }

  // 家族全体の家事履歴API
  Future<TotalPointHistory> getTotalPointHistory() async {
    final res = await http.get(
      _makeUri('/point-histories/total'),
      headers: await _makeAuthenticatedHeader(),
    );
    final dynamic data = _decodeResponse(res)['data'];
    return TotalPointHistory.fromJson(data);
  }

  // ごほうび履歴API
  Future<List<RewardHistory>> getRewardHistoryList(int rewardId) async {
    final res = await http.get(
      _makeUri('/rewards/$rewardId/history'),
      headers: await _makeAuthenticatedHeader(),
    );
    final List<dynamic> data = _decodeResponse(res)['data'];
    return data.map((json) => RewardHistory.fromJson(json)).toList();
  }

  // 問い合わせAPI
  Future<bool> postInquiry({required String title, required String body}) async {
    final res = await http.post(
      _makeUri('/inquiry'),
      headers: await _makeAuthenticatedHeader(),
      body: jsonEncode({'title': title, 'body': body}),
    );
    return _checkStatusCode(res);
  }
}

class ApiException implements Exception {
  String message;

  ApiException(this.message);
}
