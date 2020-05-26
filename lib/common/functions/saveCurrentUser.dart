import 'package:hyrd/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveCurrentUser(ProfileModel profile) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  print(profile.toString());
  await preferences.setString('user', profile.data.toString());
  await preferences.setString('userId', profile.data.id.toString());
}
