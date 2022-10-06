import 'package:black_wind_eoffice_mobile_app/provider/announce_inside.dart';
import 'package:black_wind_eoffice_mobile_app/provider/email_provider.dart';
import 'package:black_wind_eoffice_mobile_app/provider/news_provider.dart';
import 'package:black_wind_eoffice_mobile_app/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screen/login_screen.dart';
import './screen/splash_screen.dart';
import './provider/login_provider.dart';
import './provider/info_user.dart';

void main() {
  runApp(const EofficeApp());
}

class EofficeApp extends StatelessWidget {
  const EofficeApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginAuth()),
        ChangeNotifierProxyProvider<LoginAuth, EmailProvider>(
            create: (context) => EmailProvider(token: ''),
            update: (context, auth, _) =>
                EmailProvider(token: auth.token.toString())),
        ChangeNotifierProxyProvider<LoginAuth, InfoUser>(
            create: (context) => InfoUser(token: ''),
            update: (context, auth, _) =>
                InfoUser(token: auth.token.toString())),
        ChangeNotifierProxyProvider<LoginAuth, AnnounceInside>(
            create: (context) => AnnounceInside(token: ''),
            update: (context, auth, _) =>
                AnnounceInside(token: auth.token.toString())),
        ChangeNotifierProxyProvider<LoginAuth, NewsProvider>(
            create: (context) => NewsProvider(token: ''),
            update: (context, auth, _) =>
                NewsProvider(token: auth.token.toString())),
      ],
      child: Consumer<LoginAuth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: auth.isAuth
              ? const MainScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const LoginScreen()),
          routes: {
            LoginScreen.routeName: (context) => const LoginScreen(),
            MainScreen.routeName: (context) => const MainScreen(),
          },
        ),
      ),
    );
  }
}
