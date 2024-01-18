import 'package:flutter/material.dart';
import 'package:date_app/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() async {
    _user = null;
    await _storage.delete(key: 'token');
    notifyListeners();
  }
}
