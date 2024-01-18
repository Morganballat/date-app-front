import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:date_app/models/user.dart';
import 'package:date_app/helpers/appli_api.dart';

class UserController {
  static const _storage = FlutterSecureStorage();

  static Future<User> getUser(String userName, String password) async {
    var responseMap = await AppliAPI.post(
        '/user', {'email': userName, 'password': password},
        error: 'Fail to login');
    User user = User(
        id: responseMap['id'],
        firstName: responseMap['firstname'],
        lastName: responseMap['lastname'],
        email: responseMap['email'],
        role: 0);

    return user;
  }

  static Future<void> deleteUser(int userId) async {
    var response = await AppliAPI.get('/user/$userId/delete');
    await _storage.delete(key: 'token');
    return response;
  }

  static Future<void> changePassword(int userId, String newPassword) async {
    var response = await AppliAPI.post(
        '/user/$userId/edit_password', {'password': newPassword},
        error: 'Fail to login');
    return response;
  }
}
