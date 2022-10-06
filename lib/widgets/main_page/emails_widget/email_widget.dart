import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/email_provider.dart';
import 'email_item.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<EmailProvider>(context, listen: false).getEmails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return const SizedBox(
              child: Text('Lỗi ...'),
            );
          } else {
            return Consumer<EmailProvider>(
              builder: (context, mailProvider, _) => Column(
                children: mailProvider.emails
                    .map((mail) => EmailItem(
                        sender: mail['sender'],
                        mailSubject: mail['mail_subject'],
                        date: mail['send_date'],
                        linkImage: mail['sender_picture'].toString(),
                        totalView: mail['total_user_view'].toString()))
                    .toList(),
              ),
            );
          }
        });
  }
}
