import 'package:flutter/material.dart';
import '../widgets/main_page/custom_app_bar.dart';
import '../widgets/main_page/list_info.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 38, 112, 205),
      child: Expanded(
        child: Column(children: const [
          CustomAppBar(),
          ListInfo(),
        ]),
      ),
    );
  }
}
