import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginAuth with ChangeNotifier {
  String? _token;
  String? _refreshToken;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    return _token == null ? '' : _token.toString();
  }

  Future<void> signIn(String userName, String pass) async {
    final url = Uri.parse('http://insite-test.blackwind.vn/app/auth/token');
    try {
      var response = await http.post(url,
          headers: {
            'Accept': 'application/json',
            'Cache-Control': 'no-cache',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'user_name': userName, //ma nhan vien tren man hinh
            'password': pass, //mat khau tren man
            'platform': 'mobile',
            'device_token': '',
          }));
      debugPrint(json.decode(response.body).toString());
      var reponseData = jsonDecode(response.body);
      if (reponseData['status'] != 200) {
        throw Exception(reponseData['message']);
      }
      _token = reponseData['data']['accessToken'];
      _refreshToken = reponseData['data']['refreshToken'].toString();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final tokenData = json.encode({
        'token': _token.toString(),
        'refreshToken': _refreshToken,
      });
      await prefs.setString('tokenData', tokenData);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('tokenData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('tokenData').toString());

    _token = extractedUserData['token'];
    _refreshToken = extractedUserData['refreshToken'].toString();
    // debugPrint(_token);
    notifyListeners();
    return true;
  }

  Future<void> refreshToken() async {
    final url =
        Uri.parse('http://insite-test.blackwind.vn/app/auth/refresh-token');
    try {
      var response = await http.post(url,
          headers: {
            'Accept': 'application/json',
            'Cache-Control': 'no-cache',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'refreshToken': _refreshToken,
          }));
      debugPrint(json.decode(response.body).toString());
      final reponseData = jsonDecode(response.body);
      if (reponseData['status'] == '401') {
        throw Exception('Unauthorized');
      } else if (reponseData['status'] != 200) {
        throw Exception(reponseData['message']);
      }
      _token = reponseData['data']['accessToken'];
      _refreshToken = reponseData['data']['refreshToken'].toString();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final tokenData = json.encode({
        'token': _token.toString(),
        'refreshToken': _refreshToken,
      });
      prefs.reload();
      await prefs.setString('tokenData', tokenData);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> logout() async {
    final url = Uri.parse('http://insite-test.blackwind.vn/app/auth/logout');
    var respone = await http.post(url, headers: {
      'Accept': 'application/json',
      'Cache-Control': 'no-cache',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_token.toString()}',
    });
    final reponseData = jsonDecode(respone.body);
    if (reponseData['status'] != 200) {
      throw Exception(reponseData['message']);
    }
    _token = null;
    _refreshToken = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
