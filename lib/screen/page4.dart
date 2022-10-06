import 'package:black_wind_eoffice_mobile_app/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/login_provider.dart';

class Page4 extends StatefulWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  Future<void> _callLogOut() async {
    try {
      await Provider.of<LoginAuth>(context, listen: false).logout();
      if (!mounted) return;
      Navigator.of(context).pushNamed(LoginScreen.routeName);
    } on Exception catch (error) {
      debugPrint(error.toString());
      Navigator.of(context).pushNamed(LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Page 4'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _callLogOut, child: const Icon(Icons.logout)),
    );
  }
}
