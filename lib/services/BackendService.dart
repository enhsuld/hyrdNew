import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/models/json_data.dart';
import 'package:hyrd/models/post_model.dart';
import 'package:hyrd/models/profile_model.dart';
import 'package:hyrd/models/taxonomy.dart';
import 'package:hyrd/utils/debug_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackendService {
  static String api = "https://hyrd.mn/api";

  static String apiAds = api + "/car-ads";

  final BuildContext _context;

  static Map<String, String> header = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  BackendService(BuildContext context) : _context = context;

  JsonData _detect401(http.Response response) {
    if (response.statusCode == 401) {
      debugPrint(
          'detect 401: request=${response.request.url}, response-body=${utf8.decode(response.bodyBytes)}');
      DebugUtil.dumpStackTrace(5, startLevel: 2);

      final navigator = Navigator.of(_context);
      while (navigator.canPop()) {
        navigator.pop();
      }
      navigator.pushReplacementNamed('/Login');
      return null;
    } else {
      return JsonData(utf8.decode(response.bodyBytes));
    }
  }

  static Future<String> getVerifyCode({Map<String, String> body}) async {
    if (body["country_code"] != null &&
        body["country_code"].toString().isNotEmpty)
      body["country_code"] = body["country_code"].replaceAll("+", "");
    print(body);
    final response = (await http.post(api + '/verify/phone', body: body));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<http.Response> getVerifyEqual(
      {Map<String, String> body}) async {
    if (body["country_code"] != null &&
        body["country_code"].toString().isNotEmpty)
      body["country_code"] = body["country_code"].replaceAll("+", "");
    print(body);
    final response = (await http.post(api + '/verify/code', body: body));
    print(response.statusCode);
    return response;
    // if (response.statusCode == 200) {
    //   return response;
    // } else {
    //   print(json.decode(response.body)["error"]["message"]);
    //   return null;
    // }
  }

  static Future<http.Response> postRegister({Map<String, String> body}) async {
    // if (body["country_code"] != null &&
    //     body["country_code"].toString().isNotEmpty)
    //   body["country_code"] = body["country_code"].replaceAll("+", "");
    print(body);
    final response = (await http.post(api + '/register',
        headers: {"Accept": "application/json"}, body: body));
    print(response.statusCode);
    return response;
  }

  static Future<String> postAdsView({id}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString("token") != null &&
        preferences.getString("token").isNotEmpty) {
      final response = (await http.post(apiAds + '/$id/views', headers: {
        "Authorization": "Bearer " + preferences.getString("token")
      }));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<dynamic>> getAds({page, pageSize: 10}) async {
    final response = (await http.post(apiAds + '?page=$page&limit=$pageSize'));
    if (response.statusCode == 200) {
      return Future.value(JsonData(utf8.decode(response.bodyBytes)).getData());
    } else {
      return null;
    }
  }

  static Future<List<dynamic>> getPopular({page, pageSize: 10}) async {
    final response =
        (await http.get(apiAds + '/popular?page=$page&limit=$pageSize'
            //headers: {"Content-Type": "application/json"}
            ));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Future.value(JsonData(utf8.decode(response.bodyBytes)).getData());
    } else {
      return null;
    }
  }

  static Future<List<dynamic>> getHighlight({page, pageSize: 10}) async {
    final response =
        (await http.get(apiAds + '/highlight?page=$page&limit=$pageSize'));
    if (response.statusCode == 200) {
      return Future.value(JsonData(utf8.decode(response.bodyBytes)).getData());
    } else {
      return null;
    }
  }

  static Future<List<TaxonomyModel>> getTaxonomies({taxonomy = ''}) async {
    final responseBody = (await http.get(api + '/taxonomies$taxonomy'));
    print(responseBody);
    return TaxonomyModel.fromJsonList(
        json.decode(utf8.decode(responseBody.bodyBytes)));
  }

  static updateCarAds({Map<String, dynamic> taxonomy, int id}) async {
    FormData formData = new FormData.from(taxonomy);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";
    Map<String, String> map = new HashMap();
    if (token.length > 0) {
      map[HttpHeaders.authorizationHeader] = "Bearer $token";
    }

    print(formData);
    Dio dio = new Dio();
    var response = await dio.put(api + "/car-ads/" + id.toString(),
        data: formData, options: Options(headers: map));

    print(response.statusCode);
    print(response.toString());
    if (response.statusCode == 200)
      return CarModel.fromJson(json.decode(response.toString()));
    else
      return null;
  }

  static Future<Map<String, dynamic>> uploadFiles(
      Map<String, dynamic> item, List<UploadFileInfo> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    Map<String, String> map = new HashMap();
    if (token.length > 0) {
      map[HttpHeaders.authorizationHeader] = "Bearer $token";
    }
    FormData formData = new FormData.from(item);
    formData.add("media[]", data);
    print(formData);
    Dio dio = new Dio();
    var responseBody = await dio.post(api + "/car-ads",
        data: formData, options: Options(headers: map));
    print(responseBody.statusCode);
    Map<String, dynamic> taxonomy = responseBody.data;
    print(taxonomy);
    print(responseBody.data);
    // return CarModel.fromJson(json.decode(taxonomy.toString()).data);
    return responseBody.data;
  }

  static logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setBool('isLogin', false);
    print("logout");
    await preferences.setString('Name', "");
    await preferences.setString('userName', "");
    await preferences.setString('LastEmail', "");
    await preferences.setString('Token', "");
    await preferences.setString('Email', "");
    await preferences.setString('avatar', "");
    await preferences.setInt('UserId', 0);
  }

  static getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("Token") ?? "";
  }

  static Future<List<CarModel>> getCashList(
    offset,
    limit,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    Map<String, String> map = new HashMap();
    if (token.length > 0)
      map[HttpHeaders.authorizationHeader] = "Bearer $token";
    final responseBody = (await http
            .get(api + '/user/car-ads?page=$offset&limit=$limit', headers: map))
        .body;
    print(api + '/user/car-ads?page=$offset&limit=$limit');
    print(responseBody);

    return CarModel.fromJsonList(json.decode(responseBody));
  }

  static Future<int> createFeedback({Map<String, dynamic> taxonomy}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";
    Map<String, String> map = new HashMap();
    map[HttpHeaders.CONTENT_TYPE] = "application/json";
    if (token.length > 0) {
      map[HttpHeaders.authorizationHeader] = "Bearer $token";
    }

    Dio dio = new Dio();
    var response = await dio.post(api + "/feedbacks",
        data: json.encode(taxonomy), options: Options(headers: map));

    print(response.statusCode);
    return response.statusCode;
  }

  static Future<Map<String, dynamic>> crud(
      String method, String url, Map<String, dynamic> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    print(url);
    Map<String, String> map = new HashMap();
    map[HttpHeaders.CONTENT_TYPE] = "application/json";
    if (token.length > 0) {
      map[HttpHeaders.authorizationHeader] = "Bearer $token";
    }

    if (method == "delete") {
      print(api + "$url");
      map[HttpHeaders.CONTENT_TYPE] = "application/json";
      Dio dio = new Dio();
      var response =
          await dio.delete(api + "$url", options: Options(headers: map));
      print(response.statusCode);
      return response.data;
    }

    if (method == "put" && url == "user") {
      map[HttpHeaders.CONTENT_TYPE] = "application/json";
      map[HttpHeaders.ACCEPT] = "application/json";
      final responseBody =
          await http.put(api + '/user', headers: map, body: json.encode(data));
      print(responseBody.body);
      if (responseBody.statusCode == 200)
        return json.decode(responseBody.body);
      else
        return null;
    }
  }

  static Future<ProfileModel> getUserProfileData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    Map<String, String> map = new HashMap();
    if (token.length > 0)
      map[HttpHeaders.authorizationHeader] = "Bearer $token";

    final responseBody = (await http.get(api + '/user', headers: map)).body;
    print(responseBody);
    return ProfileModel.fromJson(json.decode(responseBody));
  }

  static Future<Map<String, dynamic>> updateUser(
      Map<String, dynamic> userMap) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    Map<String, String> map = new HashMap();
    if (token.length > 0)
      map[HttpHeaders.authorizationHeader] = "Bearer $token";
    map[HttpHeaders.CONTENT_TYPE] = "application/json";
    final responseBody = await http.put(api + '/user/settings',
        headers: map, body: json.encode(userMap));
    print(responseBody.body);
    if (responseBody.statusCode == 200)
      return json.decode(responseBody.body);
    else
      return null;
  }

  static Future<Map<String, dynamic>> uploadProfile(
      {url = 'doc', FormData data}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    Map<String, String> map = new HashMap();
    if (token.length > 0) {
      map[HttpHeaders.authorizationHeader] = "Bearer $token";
    }
    Dio dio = new Dio();
    var response = await dio.post(api + "/user/avatar",
        data: data, options: Options(headers: map));
    print(response);
    return response.data;
  }

  static Future<List<CarModel>> getPopularList(
    offset,
    limit,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";
    Map<String, String> map = new HashMap();
    if (token.length > 0)
      map[HttpHeaders.authorizationHeader] = "Bearer $token";
    final responseBody = (await http.get(
            api + '/car-ads/popular?page=$offset&limit=$limit',
            headers: map))
        .body;
    print(api + '/car-ads/popular?page=$offset&limit=$limit');
    print(responseBody);

    return CarModel.fromJsonList(json.decode(responseBody));
  }

  static Future<List<CarModel>> getSpecialList(
    offset,
    limit,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";
    Map<String, String> map = new HashMap();
    if (token.length > 0)
      map[HttpHeaders.authorizationHeader] = "Bearer $token";
    final responseBody = (await http.get(
            api + '/car-ads/highlight?page=$offset&limit=$limit',
            headers: map))
        .body;
    print(api + '/car-ads/highlight?page=$offset&limit=$limit');
    print(responseBody);

    return CarModel.fromJsonList(json.decode(responseBody));
  }

  static Future<List<CarModel>> getOrgAds(orgId, offset, limit) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";
    Map<String, String> map = new HashMap();
    if (token.length > 0)
      map[HttpHeaders.authorizationHeader] = "Bearer $token";
    final responseBody = (await http.get(
            api + '/orgs/$orgId/car-ads?page=$offset&limit=$limit',
            headers: map))
        .body;
    print(api + '/orgs/$orgId/car-ads?page=$offset&limit=$limit');
    print(responseBody);

    return CarModel.fromJsonList(json.decode(responseBody));
  }

  static Future<List<PostModel>> getOrgPosts(orgId, offset, limit) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";
    Map<String, String> map = new HashMap();
    if (token.length > 0)
      map[HttpHeaders.authorizationHeader] = "Bearer $token";
    final responseBody = (await http.get(
            api + '/orgs/$orgId/posts?page=$offset&limit=$limit',
            headers: map))
        .body;
    print(api + '/orgs/$orgId/posts?page=$offset&limit=$limit');
    print(responseBody);

    return PostModel.fromJsonList(json.decode(responseBody));
  }

  static Future<List<PostModel>> getPosts(offset, limit) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";
    Map<String, String> map = new HashMap();
    if (token.length > 0)
      map[HttpHeaders.authorizationHeader] = "Bearer $token";
    final responseBody =
        (await http.get(api + '/posts?page=$offset&limit=$limit', headers: map))
            .body;
    print(api + '/posts?page=$offset&limit=$limit');
    print(responseBody);

    return PostModel.fromJsonList(json.decode(responseBody));
  }

/*  static Future<List<dynamic>> getHighlight({page, pageSize: 10}) async {
    final response =
    (await http.get(apiAds + '/highlight?page=$page&limit=$pageSize'));
    if (response.statusCode == 200) {
      return Future.value(JsonData(utf8.decode(response.bodyBytes)).getData());
    } else {
      return null;
    }
  }*/

// static Future<List<ProjectModel>> getSearch(search, offset, limit) async {
//   var params = 'page=$offset&size=$limit';
//   if (search.startsWith("search=") && search.length > 7) {
//     params = search + '&page=$offset&size=$limit';
//   } else if (search.length > 1) {
//     params = search + '&page=$offset&size=$limit';
//   }
//   final responseBody =
//       (await http.get(apiV1 + '/search/manual?$params')).body;
//   //print(responseBody);
//   return ProjectModel.fromJsonList(json.decode(responseBody), 'content');
// }

}
