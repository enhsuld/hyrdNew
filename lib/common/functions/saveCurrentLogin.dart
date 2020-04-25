import 'package:shared_preferences/shared_preferences.dart';

saveCurrentLogin(Map responseJson) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  var token;
  if ((responseJson != null && responseJson.isNotEmpty)) {
    token = responseJson["success"]["token"];
  } else {
    token = "";
  }
  print(responseJson.toString());
  print("hatnaa.token $token");
  await preferences.setString('token', (token != null && token.length > 0) ? token : "");
  await preferences.setString('token', (token != null && token.length > 0) ? token : "");
}
