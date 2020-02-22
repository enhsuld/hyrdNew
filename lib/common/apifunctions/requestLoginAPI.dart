import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hyrd/common/functions/saveCurrentLogin.dart';
import 'package:hyrd/common/functions/showDialogSingleButton.dart';
import 'package:hyrd/services/BackendService.dart';

Future<dynamic> requestLoginAPI(
    BuildContext context, String phone, String password) async {
  Map data = {
    'phone': phone,
    'password': password,
  };

  var body = json.encode(data);

  final response = await http.post(
    BackendService.api + "/login",
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);
    print("logged user " + responseJson.toString());
    saveCurrentLogin(responseJson);
    return responseJson;
  } else {
    final responseJson = json.decode(response.body);

    saveCurrentLogin(responseJson);
    showDialogSingleButton(context, "Амжилтгүй",
        "Утасны дугаар эсвэл нууц үг буруу байна", "Хаах");
    return null;
  }
}
