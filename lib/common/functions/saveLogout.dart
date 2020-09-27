import 'package:hyrd/services/BackendService.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveLogout() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString('token', "");
  BackendService.isLogin = false;
}
