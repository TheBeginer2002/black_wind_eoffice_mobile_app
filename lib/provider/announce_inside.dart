import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AnnounceInside with ChangeNotifier {
  final String token;
  AnnounceInside({required this.token});

  List _insiderNews = [];

  List get insiderNews {
    return [..._insiderNews];
  }

  static const notify = {
    'GET_NOTIFY': 'announce',
    'GET_TOTAL_UNREAD': 'announce/total-unread',
  };

  Future<void> getAnnounceInside() async {
    if (token == '') {
      throw Exception('no token');
    }
    final url =
        Uri.http('insite-test.blackwind.vn', '/app/${notify['GET_NOTIFY']}', {
      'page': '1',
      'itemsPerPage': '50',
    });
    try {
      var response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Cache-Control': 'no-cache',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      // debugPrint(json.decode(response.body).toString());
      var responseData = json.decode(response.body);
      if (responseData['status'] != 200) {
        throw Exception(responseData['message']);
      }
      _insiderNews = responseData['data']['items'];
      notifyListeners();
    } on Exception catch (error) {
      return Future.error(error);
      // throw Exception(error);
    }
  }
}
