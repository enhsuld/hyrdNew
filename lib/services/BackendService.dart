import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/models/json_data.dart';
import 'package:hyrd/models/taxonomy.dart';
import 'package:hyrd/utils/debug_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackendService {
  static String api = "https://hyrd.mn/api";

  static String apiAds = api + "/car-ads";

  final BuildContext _context;

  static Map<String, String> header = {"Content-Type": "application/json"};

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

  static Future<String> getVerifyCode({phone}) async {
    final response = (await http.post(api + '/verify/phone', body: phone));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
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
    return TaxonomyModel.fromJsonList(json.decode(utf8.decode(responseBody.bodyBytes)));
  }

  static createCarAds({Map<String, dynamic> taxonomy}) async {
    FormData formData = new FormData.from(taxonomy);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("Token") ?? "";
    Map<String, String> map = new HashMap();
    if (token.length > 0) {
      map[HttpHeaders.authorizationHeader] = "Bearer $token";
    }

    print(formData);
    Dio dio = new Dio();
    var response = await dio.post(api + "/car-ads", data: formData, options: Options(headers: map));

    print(response.statusCode);
    print(response.toString());
    if (response.statusCode == 200)
      return CarModel.fromJson(json.decode(response.toString()));
    else
      return null;

  }

  static Future<Map<String, dynamic>> uploadFiles(Map<String, dynamic> item,  List<UploadFileInfo> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    Map<String, String> map = new HashMap();
    if (token.length > 0) {
      map[HttpHeaders.authorizationHeader] = "Bearer $token";
    }
    print("aaa");
    print(token);
    print(map);
    FormData formData = new FormData.from(item);
    formData.add("media[]", data);
    print(formData);
    Dio dio = new Dio();
    var response = await dio.post(api + "/car-ads", data: formData, options: Options(headers: map));
    print(response.statusCode);
    print(response.data);
    return response.data;
  }

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
