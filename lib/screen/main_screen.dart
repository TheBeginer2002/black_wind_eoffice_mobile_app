import 'package:flutter/material.dart';
import '../screen/page1.dart';
import '../screen/page2.dart';
import '../screen/page3.dart';
import '../screen/page4.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _listPage = [
    const Page1(),
    const Page2(),
    const Page3(),
    const Page4()
  ];
  final _controller = PageController();
  int _indexSelected = 0;

  void _onSelected(int index) {
    setState(() {
      _indexSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: _onSelected,
        children: _listPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/bottom_tab/bw_u.png'),
                size: 25,
              ),
              label: 'Trang Chủ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Đơn Hàng'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'Nhân viên'),
          BottomNavigationBarItem(icon: Icon(Icons.widgets), label: 'Cài Đặt')
        ],
        currentIndex: _indexSelected,
        onTap: (index) => _controller.animateToPage(index,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn),
        selectedItemColor: const Color.fromARGB(255, 38, 112, 205),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
