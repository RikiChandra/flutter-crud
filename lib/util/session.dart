import 'package:medical_app/model/user_login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const isLogin = 'islogin';
const userId = 'userid';
const userName = 'username';
const name = 'name';
const accessToken = 'accessToken';

Future createUserSession(User user) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(isLogin, true);
  prefs.setInt(userId, user.user.id);
  prefs.setString(userName, user.user.username);
  prefs.setString(name, user.user.name);
  prefs.setString(accessToken, user.accessToken);
  return true;
}

Future clearSession() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  return true;
}
