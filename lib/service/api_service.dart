import 'dart:convert';
import 'package:cajico_app/model/house_work_data.dart';
import 'package:cajico_app/model/inquiry_data.dart';
import 'package:cajico_app/model/my_page_data.dart';
import 'package:cajico_app/model/register_data.dart';
import 'package:cajico_app/model/reward_data.dart';
import 'package:cajico_app/model/schedule_data.dart';
import 'package:cajico_app/model/stamp.dart';
import 'package:cajico_app/util/xfile_extension.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_data.dart';
import '../model/masters.dart';
import '../model/my_page.dart';
import '../model/pagination_response.dart';
import '../model/point_history.dart';
import '../model/house_works.dart';
import 'package:http/http.dart' as http;
import '../model/notice.dart';
import '../model/family_reward.dart';
import '../model/reward_history.dart';
import '../model/schedule_appointment_data.dart';

class ApiService extends GetConnect {
  String? token;
  static const _commonHeaders = {
    'content-type': 'application/json',
  };

  // SharedPreferencesからトークンを取得
  _setToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? localToken = localStorage.getString('token');

    // なぜかlocalStorageから取得した値の前後に"が入るので仕方なくここで置換する
    if (localToken != null) {
      token = localToken.replaceAll('"', '');
    }
  }

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
    } else if (statusCode == 500) {
      final body = json.decode(response.body);
      throw ApiException(body['errorMessage'] ?? 'エラーが発生しました');
    } else {
      throw ApiException('エラーが発生しました');
    }
  }

  Future<Map<String, String>> makeAuthorizationBearerHeader() async {
    await _setToken();
    return {
      'Authorization': "Bearer $token",
    };
  }

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
  Future<String?> login(LoginData loginData) async {
    final res = await http.post(
      _makeUri('/login'),
      headers: _commonHeaders,
      body: jsonEncode({'email': loginData.email(), 'password': loginData.password()}),
    );
    final String? token = _decodeResponse(res)['data']['accessToken'];
    return token;
  }

  // パスワードリセットAPI
  Future<String?> resetPassword({required token, required password}) async {
    final res = await http.post(
      _makeUri('/reset/password'),
      headers: _commonHeaders,
      body: jsonEncode({'token': token, 'password': password}),
    );
    final String? accessToken = _decodeResponse(res)['data']['accessToken'];
    return accessToken;
  }

  // ログアウトAPI
  Future<bool> logout() async {
    final res = await http.post(
      _makeUri('/logout'),
      headers: await _makeAuthenticatedHeader(),
    );
    return _checkStatusCode(res);
  }

  // メール認証API
  Future<bool> sendEmail({required email, required type}) async {
    final res = await http.post(
      _makeUri('/register/email'),
      headers: _commonHeaders,
      body: jsonEncode({'email': email, 'type': type}),
    );
    return _checkStatusCode(res);
  }

  // 招待メール送信API
  Future<bool> sendInvitationEmail({required email, required type}) async {
    final res = await http.post(
      _makeUri('/invite-user'),
      headers: await _makeAuthenticatedHeader(),
      body: jsonEncode({'email': email, 'type': type}),
    );
    return _checkStatusCode(res);
  }

  // 新規家族コード認証API
  Future<bool> confirmNewFamily(NewFamilyData newFamilyData) async {
    final res = await http.post(
      _makeUri('/confirm/new-family'),
      headers: _commonHeaders,
      body: jsonEncode({
        'type': newFamilyData.type(),
        'token': newFamilyData.token(),
        'familyName': newFamilyData.familyName(),
        'familyCode': newFamilyData.familyCode(),
      }),
    );
    return _checkStatusCode(res);
  }

  // 参加家族コード認証API
  Future<bool> confirmJoinFamily(NewFamilyData newFamilyData) async {
    final res = await http.post(
      _makeUri('/confirm/join-family'),
      headers: _commonHeaders,
      body: jsonEncode({
        'type': newFamilyData.type(),
        'token': newFamilyData.token(),
        'familyName': newFamilyData.familyName(),
        'familyCode': newFamilyData.familyCode(),
      }),
    );
    return _checkStatusCode(res);
  }

  // 新規家族&ユーザー登録API
  Future<String?> createFamilyAndUser(NewFamilyData newFamilyData) async {
    final request = http.MultipartRequest('POST', _makeUri('/register/new-family'));
    request.headers.addAll(_commonHeaders);
    if (newFamilyData.iconImage() != null) {
      XFile xFile = XFile(newFamilyData.iconImage()!.path);
      request.files.add(await xFile.toMultiPartFileField(
        filename: 'user_icon',
        fieldName: 'iconImage',
      ));
    }
    final Map<String, dynamic> data = {
      'token': newFamilyData.token(),
      'familyName': newFamilyData.familyName(),
      'familyCode': newFamilyData.familyCode(),
      'userName': newFamilyData.userName(),
      'positionId': newFamilyData.positionId().toString(),
      'password': newFamilyData.password(),
    };
    request.fields.addAll(Map<String, String>.from(data));
    final response = await request.send();
    final res = await http.Response.fromStream(response);
    final String? token = _decodeResponse(res)['data']['accessToken'];
    return token;
  }

  // 家族参加&ユーザー登録API
  Future<String?> joinFamilyAndCreateUser(NewFamilyData newFamilyData) async {
    final request = http.MultipartRequest('POST', _makeUri('/register/join-family'));
    request.headers.addAll(_commonHeaders);
    if (newFamilyData.iconImage() != null) {
      XFile xFile = XFile(newFamilyData.iconImage()!.path);
      request.files.add(await xFile.toMultiPartFileField(
        filename: 'user_icon',
        fieldName: 'iconImage',
      ));
    }
    final Map<String, dynamic> data = {
      'token': newFamilyData.token(),
      'familyName': newFamilyData.familyName(),
      'familyCode': newFamilyData.familyCode(),
      'userName': newFamilyData.userName(),
      'positionId': newFamilyData.positionId().toString(),
      'password': newFamilyData.password(),
    };
    request.fields.addAll(Map<String, String>.from(data));
    final response = await request.send();
    final res = await http.Response.fromStream(response);
    final String? token = _decodeResponse(res)['data']['accessToken'];
    return token;
  }

  // ユーザー登録（招待）API
  Future<String?> joinFamilyAndCreateUserByInvitation(NewFamilyData newFamilyData) async {
    final request = http.MultipartRequest('POST', _makeUri('/register/join-family-by-invitation'));
    request.headers.addAll(_commonHeaders);
    if (newFamilyData.iconImage() != null) {
      XFile xFile = XFile(newFamilyData.iconImage()!.path);
      request.files.add(await xFile.toMultiPartFileField(
        filename: 'user_icon',
        fieldName: 'iconImage',
      ));
    }
    final Map<String, dynamic> data = {
      'token': newFamilyData.token(),
      'familyId': newFamilyData.familyId(),
      'userName': newFamilyData.userName(),
      'positionId': newFamilyData.positionId().toString(),
      'password': newFamilyData.password(),
    };
    request.fields.addAll(Map<String, String>.from(data));
    final response = await request.send();
    final res = await http.Response.fromStream(response);
    final String? token = _decodeResponse(res)['data']['accessToken'];
    return token;
  }

  // デバイストークン更新API
  Future<bool> registerDeviceToken({required deviceToken}) async {
    final res = await http.put(
      _makeUri('/me/device_token'),
      headers: await _makeAuthenticatedHeader(),
      body: jsonEncode({'deviceToken': deviceToken}),
    );
    return _checkStatusCode(res);
  }

  // マイページ取得API
  Future<MyPage> getMyPage() async {
    final res = await http.get(
      _makeUri('/me'),
      headers: await _makeAuthenticatedHeader(),
    );
    final dynamic data = _decodeResponse(res)['data'];
    return MyPage.fromJson(data);
  }

  // マイページ更新API
  Future<bool> updateMyPage(MyPageData myPageData) async {
    final request = http.MultipartRequest('POST', _makeUri('/me'));
    request.headers.addAll(await _makeAuthenticatedHeader());
    if (myPageData.iconImage() != null) {
      XFile xFile = XFile(myPageData.iconImage()!.path);
      request.files.add(await xFile.toMultiPartFileField(
        filename: 'user_icon',
        fieldName: 'iconImage',
      ));
    }
    final Map<String, dynamic> data = {
      'familyName': myPageData.familyName(),
      'familyCode': myPageData.familyCode(),
      'userName': myPageData.userName(),
      'positionId': myPageData.positionId().toString(),
    };
    request.fields.addAll(Map<String, String>.from(data));
    final response = await request.send();
    final res = await http.Response.fromStream(response);
    return _checkStatusCode(res);
  }

  // 退会API（ユーザーのみ）
  Future<bool> deleteUser() async {
    final res = await http.delete(
      _makeUri('/me/delete'),
      headers: await _makeAuthenticatedHeader(),
    );
    return _checkStatusCode(res);
  }

  // 退会API（家族ごと）
  Future<bool> deleteFamily() async {
    final res = await http.delete(
      _makeUri('/me/delete-all'),
      headers: await _makeAuthenticatedHeader(),
    );
    return _checkStatusCode(res);
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

  // 家族の家事全取得API
  Future<List<Master>> getAllHouseWorksList() async {
    final res = await http.get(
      _makeUri('/house-works-all'),
      headers: await _makeAuthenticatedHeader(),
    );
    final List<dynamic> data = _decodeResponse(res)['data'];
    return data.map((json) => Master.fromJson(json)).toList();
  }

  // 家事登録API
  Future<bool> createHouseWork(HouseWorkCreateData houseWorkCreateData) async {
    final res = await http.post(
      _makeUri('/house-works'),
      headers: await _makeAuthenticatedHeader(),
      body: jsonEncode({
        'houseWorkCategoryId': houseWorkCreateData.houseWorkCategoryId(),
        'name': houseWorkCreateData.houseWorkName(),
        'point': houseWorkCreateData.point(),
      }),
    );
    return _checkStatusCode(res);
  }

  // 家事更新API
  Future<bool> putHouseWork(HouseWorkEditData houseWorkEditData) async {
    final res = await http.put(
      _makeUri('/house-works/${houseWorkEditData.houseWorkId()}'),
      headers: await _makeAuthenticatedHeader(),
      body: jsonEncode({
        'name': houseWorkEditData.houseWorkName(),
        'point': houseWorkEditData.point(),
      }),
    );
    return _checkStatusCode(res);
  }

  // 家事削除API
  Future<bool> deleteHouseWork({required int houseWorkId}) async {
    final res = await http.delete(
      _makeUri('/house-works/$houseWorkId'),
      headers: await _makeAuthenticatedHeader(),
    );
    return _checkStatusCode(res);
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
  Future<PaginationResponse<List<Notice>>> getNoticesList({int page = 1}) async {
    final res = await http.get(
      _makeUri('/notices', queryParams: {
        'page': page.toString(),
      }),
      headers: await _makeAuthenticatedHeader(),
    );
    final List<dynamic> data = _decodeResponse(res)['data'];
    final dynamic meta = _decodeResponse(res)['meta'];
    return PaginationResponse(
      data: data.map((json) => Notice.fromJson(json)).toList(),
      meta: PaginationMeta.fromJson(meta),
    );
  }

  // お知らせ既読API
  Future<bool> readNotices() async {
    final res = await http.put(
      _makeUri('/notices/read'),
      headers: await _makeAuthenticatedHeader(),
    );
    return _checkStatusCode(res);
  }

  // お知らせ未読数取得API
  Future<int> getNotificationUnreadCount() async {
    final res = await http.get(
      _makeUri('/notice/unread-count'),
      headers: await _makeAuthenticatedHeader(),
    );
    final int count = _decodeResponse(res)['data']['unreadCount'];
    return count;
  }

  // 運営お知らせ一覧API
  Future<PaginationResponse<List<AdminNotice>>> getAdminNoticesList({int page = 1}) async {
    final res = await http.get(
      _makeUri('/adminNotices', queryParams: {
        'page': page.toString(),
      }),
      headers: await _makeAuthenticatedHeader(),
    );
    final List<dynamic> data = _decodeResponse(res)['data'];
    final dynamic meta = _decodeResponse(res)['meta'];
    return PaginationResponse(
      data: data.map((json) => AdminNotice.fromJson(json)).toList(),
      meta: PaginationMeta.fromJson(meta),
    );
  }

  // 運営お知らせ既読API
  Future<bool> readAdminNotice({required int noticeId}) async {
    final res = await http.put(
      _makeUri('/adminNotices/$noticeId/read'),
      headers: await _makeAuthenticatedHeader(),
    );
    return _checkStatusCode(res);
  }

  // 運営お知らせ未読数取得API
  Future<int> getAdminNotificationUnreadCount() async {
    final res = await http.get(
      _makeUri('/adminNotice/unread-count'),
      headers: await _makeAuthenticatedHeader(),
    );
    final int count = _decodeResponse(res)['data']['unreadCount'];
    return count;
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

  // ごほうび履歴API
  Future<List<RewardHistory>> getRewardHistoryList(int rewardId) async {
    final res = await http.get(
      _makeUri('/rewards/$rewardId/history'),
      headers: await _makeAuthenticatedHeader(),
    );
    final List<dynamic> data = _decodeResponse(res)['data'];
    return data.map((json) => RewardHistory.fromJson(json)).toList();
  }

  // ごほうび更新API
  Future<bool> putReward(RewardData rewardData) async {
    final res = await http.put(
      _makeUri('/rewards/${rewardData.rewardId()}'),
      headers: await _makeAuthenticatedHeader(),
      body: jsonEncode({
        'name': rewardData.rewardName(),
        'point': rewardData.point(),
        'note': rewardData.memo(),
      }),
    );
    return _checkStatusCode(res);
  }

  // ごほうびリクエストAPI
  Future<bool> requestReward({required int rewardId}) async {
    final res = await http.put(
      _makeUri('/rewards/$rewardId/request'),
      headers: await _makeAuthenticatedHeader(),
    );
    return _checkStatusCode(res);
  }

  // ねぎらい完了リクエストAPI
  Future<bool> completeReward({required int rewardId, required String body}) async {
    final res = await http.put(
      _makeUri('/rewards/$rewardId/complete'),
      headers: await _makeAuthenticatedHeader(),
      body: jsonEncode({'message': body}),
    );
    return _checkStatusCode(res);
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

  // 個人別家事履歴一覧API
  Future<List<Point>> getUserPointHistoryList({required int userId, int page = 1}) async {
    final res = await http.get(
      _makeUri('/$userId/point-histories', queryParams: {
        'page': page.toString(),
      }),
      headers: await _makeAuthenticatedHeader(),
    );
    final List<dynamic> data = _decodeResponse(res)['data'];
    return data.map((json) => Point.fromJson(json)).toList();
  }

  // 家族全体の家事履歴API
  Future<TotalPointHistory> getTotalPointHistory({int page = 1}) async {
    final res = await http.get(
      _makeUri('/point-histories/total', queryParams: {
        'page': page.toString(),
      }),
      headers: await _makeAuthenticatedHeader(),
    );
    final dynamic data = _decodeResponse(res)['data'];
    return TotalPointHistory.fromJson(data);
  }

  // 家族全体の家事履歴API
  Future<PointSummery> getMyPointSummery() async {
    final res = await http.get(
      _makeUri('/me/point-summery'),
      headers: await _makeAuthenticatedHeader(),
    );
    final dynamic data = _decodeResponse(res)['data'];
    return PointSummery.fromJson(data);
  }

  // 家事履歴削除API
  Future<bool> deletePointHistory({required int pointHistoryId}) async {
    final res = await http.delete(
      _makeUri('/point-histories/$pointHistoryId'),
      headers: await _makeAuthenticatedHeader(),
    );
    return _checkStatusCode(res);
  }

  // 問い合わせAPI
  Future<bool> postInquiry(InquiryData inquiryData) async {
    final res = await http.post(
      _makeUri('/inquiry'),
      headers: await _makeAuthenticatedHeader(),
      body: jsonEncode({'title': inquiryData.title(), 'body': inquiryData.body()}),
    );
    return _checkStatusCode(res);
  }

  // その日の予定取得API
  Future<List<ScheduleAppointmentSummary>> getScheduleAppointmentList(
      {required String date}) async {
    final res = await http.get(
      _makeUri('/schedules', queryParams: {'date': date}),
      headers: await _makeAuthenticatedHeader(),
    );
    final List<dynamic> data = _decodeResponse(res)['data'];
    return data.map((json) => ScheduleAppointmentSummary.fromJson(json)).toList();
  }

  // 週の予定取得API
  Future<List<ScheduleAppointmentSummary>> getWeeklyScheduleAppointmentList(
      {required String date}) async {
    final res = await http.get(
      _makeUri('/schedules/weekly', queryParams: {'date': date}),
      headers: await _makeAuthenticatedHeader(),
    );
    final List<dynamic> data = _decodeResponse(res)['data'];
    return data.map((json) => ScheduleAppointmentSummary.fromJson(json)).toList();
  }

  // 予定詳細取得API
  Future<ScheduleAppointment> getAppointment({
    required int scheduleId,
    required String date,
  }) async {
    final res = await http.get(
      _makeUri('/schedules/$scheduleId', queryParams: {'date': date}),
      headers: await _makeAuthenticatedHeader(),
    );
    final dynamic data = _decodeResponse(res)['data'];
    return ScheduleAppointment.fromJson(data);
  }

  // 予定登録API
  Future<bool> createSchedule(ScheduleCreateData scheduleCreateData) async {
    final res = await http.post(
      _makeUri('/schedules'),
      headers: await _makeAuthenticatedHeader(),
      body: jsonEncode({
        'date': scheduleCreateData.date(),
        'houseWorkId': scheduleCreateData.houseWorkId(),
        'startTime': scheduleCreateData.startTime(),
        'endTime': scheduleCreateData.endTime(),
        'colorCode': scheduleCreateData.colorCode(),
        'repeatRule':
            scheduleCreateData.repeatRule() != 999 ? scheduleCreateData.repeatRule() : null,
        'repeatInterval':
            scheduleCreateData.repeatRule() != 999 ? scheduleCreateData.repeatInterval() : null,
        'repeatEndDate':
            scheduleCreateData.repeatRule() != 999 ? scheduleCreateData.repeatEndDate() : null,
      }),
    );
    return _checkStatusCode(res);
  }

  // 予定更新API
  Future<bool> updateSchedule(ScheduleEditData scheduleEditData, {required String type}) async {
    final int id = scheduleEditData.scheduleId();
    final res = await http.put(
      _makeUri('/schedules/$id'),
      headers: await _makeAuthenticatedHeader(),
      body: jsonEncode({
        'type': type,
        'date': scheduleEditData.date(),
        'houseWorkId': scheduleEditData.houseWorkId(),
        'startTime': scheduleEditData.startTime(),
        'endTime': scheduleEditData.endTime(),
        'colorCode': scheduleEditData.colorCode(),
        'repeatRule': scheduleEditData.repeatRule() != 999 && type != 'only'
            ? scheduleEditData.repeatRule()
            : null,
        'repeatInterval': scheduleEditData.repeatRule() != 999 && type != 'only'
            ? scheduleEditData.repeatInterval()
            : null,
        'repeatEndDate': scheduleEditData.repeatRule() != 999 && type != 'only'
            ? scheduleEditData.repeatEndDate()
            : null,
      }),
    );
    return _checkStatusCode(res);
  }

  // 予定削除API
  Future<bool> deleteSchedule(ScheduleEditData scheduleEditData, {required String type}) async {
    final int id = scheduleEditData.scheduleId();
    final res = await http.delete(
      _makeUri('/schedules/$id'),
      headers: await _makeAuthenticatedHeader(),
      body: jsonEncode({'type': type, 'date': scheduleEditData.date()}),
    );
    return _checkStatusCode(res);
  }

  // 予定完了API
  Future<bool> completeSchedule({required int scheduleId, required String date}) async {
    final res = await http.put(
      _makeUri('/schedules/$scheduleId/complete', queryParams: {'date': date}),
      headers: await _makeAuthenticatedHeader(),
    );
    return _checkStatusCode(res);
  }

  // 予定キャンセルAPI
  Future<bool> cancelSchedule({required int scheduleId, required String date}) async {
    final res = await http.put(
      _makeUri('/schedules/$scheduleId/cancel', queryParams: {'date': date}),
      headers: await _makeAuthenticatedHeader(),
    );
    return _checkStatusCode(res);
  }

  // スタンプ一覧取得API
  Future<List<Stamp>> getStampList() async {
    final res = await http.get(
      _makeUri('/stamps/all'),
      headers: await _makeAuthenticatedHeader(),
    );
    final List<dynamic> data = _decodeResponse(res)['data'];
    return data.map((json) => Stamp.fromJson(json)).toList();
  }

  // 家事リアクションAPI
  Future<bool> reactHouseWork({required int pointHistoryId, required String type, required stampId}) async {
    final res = await http.post(
      _makeUri('/point-histories/$pointHistoryId/reaction'),
      headers: await _makeAuthenticatedHeader(),
      body: jsonEncode({'type': type, 'stampId': stampId}),
    );
    return _checkStatusCode(res);
  }
}

class ApiException implements Exception {
  String message;

  ApiException(this.message);
}
