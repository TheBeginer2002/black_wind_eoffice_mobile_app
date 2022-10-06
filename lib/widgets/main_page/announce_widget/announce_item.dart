import 'package:flutter/material.dart';

class AnnounceItem extends StatelessWidget {
  const AnnounceItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.numberAttachments,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String date;
  final int numberAttachments;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.asset('assets/images/home/notify_bw_u.png'),
      ),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(date)
      ]),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              subtitle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.attach_file),
              Text('$numberAttachments')
            ],
          )
        ],
      ),
    );
  }
}
