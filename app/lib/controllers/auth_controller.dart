import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:date_app/helpers/appli_api.dart';

class AuthController {
  static const _storage = FlutterSecureStorage();

  static Future<bool> login(String userName, String password) async {
    var responseMap = await AppliAPI.post(
        '/login_check', {'email': userName, 'password': password},
        error: 'Fail to login');
    String token = responseMap['token'];
    await _storage.write(key: 'token', value: token);

    return true;
  }

  static Future<bool> signin(
      String firstName, String lastName, String email, String password) async {
    await AppliAPI.post(
        '/signin',
        {
          'firstname': firstName,
          'lastname': lastName,
          'email': email,
          'password': password
        },
        error: 'Fail to register');
    return true;
  }

  static Future<String?> getToken() async {
    String? token = await _storage.read(key: 'token');

    return token;
  }

  static Future<bool> isLoggedIn() async {
    String? token = await getToken();

    return token != null;
  }

  static Future<void> logout() async {
    await _storage.delete(key: 'token');
  }
}
