import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:hyrd/models/json_data.dart';
import 'package:hyrd/utils/debug_util.dart';

class BackendService {
  static String api = "https://hyrd.mn/api";

  static String apiAds = api + "/car-ads";

  final BuildContext _context;
  static int pageSize = 10;

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

  static Future<String> getAds({page}) async {
    final response = (await http.post(apiAds + '?page=$page&limit=$pageSize'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String> getPopular({page}) async {
    final response =
        (await http.post(apiAds + '/popular?page=$page&limit=$pageSize'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String> getHighlight({page}) async {
    final response =
        (await http.post(api + '/highlight?page=$page&limit=$pageSize'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
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
