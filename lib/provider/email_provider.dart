import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class EmailProvider with ChangeNotifier {
  EmailProvider({required this.token});
  final String token;
  var _emails = [];
  final Map<String, dynamic> _queryParameters = {
    'page': '1',
    'itemsPerPage': '2',
    'search': '',
  };
  static const mail = {
    'MAIL_INCOMING': 'mail/incoming',
    'MAIL_INCOMING_TODAY': 'mail/incoming-in-day',
    'MAIL': 'mail',
    'MAIL_SEND': 'mail/sent',
    'MAIL_FLAGGED': 'mail/flagged',
    'MAIL_DRAFT': 'mail/draft',
    'MAIL_TRASH': 'mail/trash',
    'MAIL_DEPARTMENT': 'department/get-options',
    'MAIL_FRIEND': 'user/get-options',
    'SAVE_DRAFT': 'mail/save-draft',
    'MAIL_STATUS': 'mail/status-incoming-mail',
    'MAIL_UNDO_TRASH': 'mail/trash',
    'MAIL_UNREAD': 'mail/incoming',
  };
  List<Map<String, dynamic>> get emails {
    return [..._emails];
  }

  Future<void> getEmails() async {
    final url = Uri.http('insite-test.blackwind.vn',
        '/app/${mail['MAIL_INCOMING'].toString()}', _queryParameters);
    try {
      if (token == '') {
        throw Exception('lỗi ko token');
      }
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Cache-Control': 'no-cache',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var responseData = json.decode(response.body);
      if (responseData['status'] != 200) {
        throw Exception(responseData['message']);
      }
      _emails = responseData['data']['items'];
      // debugPrint(_emails.toString());
      notifyListeners();
    } on Exception catch (error) {
      return Future.error(error);
      // throw Exception(error);
    }
  }
}
