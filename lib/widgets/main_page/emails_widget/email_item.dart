import 'package:flutter/material.dart';

class EmailItem extends StatelessWidget {
  const EmailItem(
      {Key? key,
      required this.sender,
      required this.mailSubject,
      required this.linkImage,
      required this.date,
      required this.totalView})
      : super(key: key);
  final String mailSubject;
  final String sender;
  final String linkImage;
  final String date;
  final String totalView;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          child: Image.network(
        linkImage,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/home/notify_bw_u.png',
          fit: BoxFit.cover,
        ),
      )),
      subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(mailSubject), Text(date)]),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(sender),
          Row(
            children: [const Icon(Icons.remove_red_eye), Text(totalView)],
          )
        ],
      ),
      onTap: () {},
    );
  }
}
