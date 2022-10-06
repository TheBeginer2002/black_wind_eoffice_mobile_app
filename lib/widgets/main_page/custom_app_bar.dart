import 'dart:async';

import 'package:black_wind_eoffice_mobile_app/provider/info_user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/login_provider.dart';
import '../../screen/login_screen.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  DateTime _time = DateTime.now();
  late Timer _refreshTime;
  void _updateTime() {
    if (mounted) {
      setState(() {
        _time = DateTime.now();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshTime = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      _updateTime();
    });
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    try {
      await Provider.of<InfoUser>(context, listen: false).infoLogin();
    } on Exception catch (error) {
      if (error.toString().contains('jwt expired')) {
        _getRefreshToken().then((_) {
          setState(() {
            Provider.of<InfoUser>(context, listen: false).toggleLoading(true);
          });
        });
        // _getUserInfo();
      } else {
        Navigator.of(context).pushNamed(LoginScreen.routeName);
      }
    }
  }

  Future<void> _getRefreshToken() async {
    try {
      await Provider.of<LoginAuth>(context, listen: false).refreshToken();
    } on Exception catch (error) {
      _showErrorDialog(error.toString());
      Navigator.of(context).pushNamed(LoginScreen.routeName);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Có lỗi xảy ra'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'))
              ],
            ));
  }

  @override
  void dispose() {
    super.dispose();
    _refreshTime.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<InfoUser>(context, listen: false).userName;
    final fullName = Provider.of<InfoUser>(context, listen: false).fullName;
    final avatarImage =
        Provider.of<InfoUser>(context, listen: false).avatarImage;
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 38, 112, 205),
          image: DecorationImage(
              alignment: Alignment.topRight,
              image: AssetImage('assets/images/home/wm_bw_a.png'))),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        const SizedBox(
          height: 52,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
                child: Image.network(avatarImage, fit: BoxFit.cover,
                    errorBuilder: (context, error, _) {
              return const Icon(
                Icons.account_circle,
              );
            })),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Chào ${_time.hour >= 11 && _time.hour <= 14 ? 'buổi trưa' : _time.hour > 14 && _time.hour <= 17 ? 'buổi chiều' : _time.hour > 17 && _time.hour <= 23 ? 'buổi tối' : 'buổi sáng'}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  '$userName - $fullName',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.Hm().format(_time),
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  DateFormat('E,d/M/y').format(_time),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 70,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 28, 102, 195),
              borderRadius: BorderRadius.circular(50.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Image.asset(
                  'assets/images/home/checkInBW.png',
                  height: 48,
                  width: 48,
                ),
                onTap: () {
                  debugPrint('press Check In');
                },
              ),
              GestureDetector(
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(127, 255, 255, 255),
                        )),
                    child: Image.asset(
                      'assets/images/home/mess1.png',
                      height: 32,
                      width: 32,
                    )),
                onTap: () {
                  debugPrint('press Mail');
                },
              ),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(127, 255, 255, 255),
                      )),
                  child: Image.asset(
                    'assets/images/home/notify1.png',
                    height: 32,
                    width: 32,
                  ),
                ),
                onTap: () {
                  debugPrint('press Bell');
                },
              ),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(127, 255, 255, 255),
                      )),
                  child: Image.asset(
                    'assets/images/home/calenderBW.png',
                    height: 32,
                    width: 32,
                  ),
                ),
                onTap: () {
                  debugPrint('press Calender');
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}
