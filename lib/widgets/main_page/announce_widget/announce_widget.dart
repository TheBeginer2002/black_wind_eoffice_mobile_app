import 'package:black_wind_eoffice_mobile_app/provider/announce_inside.dart';
import 'package:black_wind_eoffice_mobile_app/widgets/main_page/announce_widget/announce_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnnounceWidget extends StatelessWidget {
  const AnnounceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<AnnounceInside>(context, listen: false)
            .getAnnounceInside(),
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
            return Consumer<AnnounceInside>(
                builder: (context, insider, _) => Column(
                      children: insider.insiderNews
                          .map((news) => AnnounceItem(
                              title: news['announce_title'],
                              subtitle: news['description'],
                              date: news['published_date'],
                              numberAttachments: news['total_attachment']))
                          .toList(),
                    ));
          }
        });
  }
}
