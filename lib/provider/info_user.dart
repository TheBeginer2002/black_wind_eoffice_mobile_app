import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class InfoUser with ChangeNotifier {
  InfoUser({required this.token});
  final String token;
  String? _fullName;
  String? _emailUser;
  String? _avatarImage;
  String? _userName;
  bool _isLoading = false;

  String get fullName {
    return _fullName == null ? 'null' : _fullName.toString();
  }

  String get emailUser {
    return _emailUser == null ? 'null' : _emailUser.toString();
  }

  String get avatarImage {
    return _avatarImage == null ? 'null' : _avatarImage.toString();
  }

  String get userName {
    return _userName == null ? 'null' : _userName.toString();
  }

  void toggleLoading(bool isNowLoading) {
    _isLoading = isNowLoading;
    notifyListeners();
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<void> infoLogin() async {
    if (token == '') {
      throw Exception('no token');
    }
    try {
      final url =
          Uri.parse('http://insite-test.blackwind.vn/app/auth/get-profile');
      var response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Cache-Control': 'no-cache',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      // debugPrint(json.decode(response.body.toString()).toString());
      var responseData = json.decode(response.body.toString());
      if (responseData['status'] != 200) {
        throw Exception(responseData['message']);
      }
      _fullName = responseData['data']['full_name'].toString();
      _emailUser = responseData['data']['email'].toString();
      _avatarImage = responseData['data']['default_picture_url'].toString();
      _userName = responseData['data']['user_name'].toString();
      notifyListeners();
    } catch (error) {
      throw Exception(error);
    }
  }
}
