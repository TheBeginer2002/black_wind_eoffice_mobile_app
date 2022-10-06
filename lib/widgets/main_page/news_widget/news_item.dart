import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  const NewsItem(
      {Key? key,
      required this.title,
      required this.linkImage,
      required this.date})
      : super(key: key);
  final String title;
  final String linkImage;
  final String date;
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder:
                    const AssetImage('assets/images/placeholder-image.png'),
                image: NetworkImage(
                  linkImage,
                ),
                imageErrorBuilder: (context, error, _) =>
                    Image.asset('assets/images/img_default.png'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(title),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [const Icon(Icons.date_range_rounded), Text(date)],
            ),
          ],
        ),
      ),
    );
  }
}
