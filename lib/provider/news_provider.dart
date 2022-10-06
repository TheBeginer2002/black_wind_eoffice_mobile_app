import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NewsProvider with ChangeNotifier {
  final String token;
  NewsProvider({required this.token});

  var _newsItems = [];

  List get newsItems {
    return _newsItems;
  }

  Future<void> getNews() async {
    final url = Uri.http('insite-test.blackwind.vn', '/app/news', {
      'page': '1',
      'itemsPerPage': '4',
      'search': '',
    });
    try {
      var response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Cache-Control': 'no-cache',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      debugPrint(json.decode(response.body).toString());
      var responseData = json.decode(response.body);
      if (responseData['status'] != 200) {
        throw Exception(responseData['message']);
      }
      _newsItems = responseData['data']['items'];
      notifyListeners();
    } on Exception catch (error) {
      return Future.error(error);
      // throw Exception(error);
    }
  }
}
