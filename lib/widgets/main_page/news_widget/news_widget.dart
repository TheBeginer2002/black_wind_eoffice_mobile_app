import 'package:black_wind_eoffice_mobile_app/provider/news_provider.dart';
import 'package:black_wind_eoffice_mobile_app/widgets/main_page/news_widget/news_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<NewsProvider>(context, listen: false).getNews(),
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
            return Consumer<NewsProvider>(
                builder: (context, newsProvider, _) => GridView.count(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(1),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: newsProvider.newsItems
                          .map((newsItem) => NewsItem(
                              title: newsItem['news_title'],
                              linkImage: newsItem['image_url'],
                              date: newsItem['news_date']))
                          .toList(),
                    ));
          }
        });
  }
}
