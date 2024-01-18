import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:date_app/controllers/auth_controller.dart';

class AppliAPI {
  static const _storage = FlutterSecureStorage();
  static const String _baseUrl = 'https://127.0.0.1:8000/api';

  static Future<Map<String, String>> _getHeaders() async {
    String? token = await AuthController.getToken() != null
        ? await AuthController.getToken()
        : "";
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  static Future<dynamic> get(String endpoint,
      {String error = 'Failed to load data'}) async {
    var response = await http.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(error);
    }
  }

  static Future<dynamic> post(String endpoint, dynamic body,
      {String error = 'Failed to post data'}) async {
    var response = await http.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: await _getHeaders(),
      body: jsonEncode(body),
    );

    if (response.statusCode > 199 && response.statusCode <= 299) {
      return jsonDecode(response.body);
    } else {
      throw Exception(error);
    }
  }

  static Future<dynamic> patch(String endpoint, dynamic body,
      {String error = 'Failed to patch data'}) async {
    var response = await http.patch(
      Uri.parse('$_baseUrl$endpoint'),
      headers: await _getHeaders(),
      body: jsonEncode(body),
    );

    if (response.statusCode > 199 && response.statusCode <= 299) {
      return jsonDecode(response.body);
    } else {
      throw Exception(error);
    }
  }
}
