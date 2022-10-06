import 'package:black_wind_eoffice_mobile_app/provider/info_user.dart';
import 'package:black_wind_eoffice_mobile_app/widgets/main_page/announce_widget/announce_widget.dart';
import 'package:black_wind_eoffice_mobile_app/widgets/main_page/emails_widget/email_widget.dart';
import 'package:black_wind_eoffice_mobile_app/widgets/main_page/news_widget/news_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListInfo extends StatefulWidget {
  const ListInfo({Key? key}) : super(key: key);

  @override
  State<ListInfo> createState() => _ListInfoState();
}

class _ListInfoState extends State<ListInfo> {
  @override
  void initState() {
    super.initState();
    bool isLoading = Provider.of<InfoUser>(context, listen: false).isLoading;
    if (isLoading) {
      setState(() {
        Provider.of<InfoUser>(context, listen: false).toggleLoading(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        width: sizeScreen.width * 0.98,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0), topRight: Radius.circular(10))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(
                        width: 8,
                      ),
                      ImageIcon(
                        AssetImage('assets/images/home/mess1.png'),
                        size: 30,
                      ),
                      Text('Hộp thư')
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.navigate_next_rounded),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  ),
                ],
              ),
              const EmailWidget(),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(
                        width: 5,
                      ),
                      ImageIcon(
                          AssetImage('assets/images/home/notifyHeader.png'),
                          size: 30),
                      Text('Thông báo nội bộ'),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.navigate_next_rounded),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  ),
                ],
              ),
              const AnnounceWidget(),
              const Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(
                        width: 5,
                      ),
                      ImageIcon(AssetImage('assets/images/home/newsHeader.png'),
                          size: 30),
                      Text('Tin tức'),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.navigate_next_rounded),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  ),
                ],
              ),
              const NewsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
