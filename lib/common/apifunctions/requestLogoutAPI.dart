import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hyrd/common/functions/saveLogout.dart';

Future<String> requestLogoutAPI(BuildContext context) async {
  //final url = "https://pims.publicinvestment.gov.mn/api/auth/logout";

  // var token;

  // await getToken().then((result) {
  //   token = result;
  // });

  // final response = await http.post(
  //   url,
  //   headers: {HttpHeaders.authorizationHeader: "Token $token"},
  // );

  // if (response.statusCode == 200) {
  saveLogout();
  return null;
  // } else {
  //   saveLogout();
  //   return null;
  // }
}
