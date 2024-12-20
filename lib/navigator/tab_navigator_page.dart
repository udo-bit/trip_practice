import 'package:flutter/material.dart';
import 'package:trip_practice/page/home_page.dart';
import 'package:trip_practice/page/my_page.dart';
import 'package:trip_practice/page/search_page.dart';
import 'package:trip_practice/page/trip_page.dart';

import '../util/navigator_util.dart';

class TabNavigatorPage extends StatefulWidget {
  const TabNavigatorPage({super.key});

  @override
  State<TabNavigatorPage> createState() => _TabNavigatorPageState();
}

class _TabNavigatorPageState extends State<TabNavigatorPage> {
  final PageController _controller = PageController(initialPage: 2);
  int _currentIndex = 2;
  final Color _defaultColor = Colors.grey;
  final Color _activeColor = Colors.orange;
  @override
  Widget build(BuildContext context) {
    NavigatorUtil.updateContext(context);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [HomePage(), SearchPage(), TripPage(), MyPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _bottomItem("主页", Icons.home, 0),
          _bottomItem("搜索", Icons.search, 1),
          _bottomItem("旅拍", Icons.camera_alt, 2),
          _bottomItem("我的", Icons.account_circle, 3)
        ],
      ),
    );
  }

  _bottomItem(String title, IconData iconData, int index) {
    return BottomNavigationBarItem(
        label: title,
        icon: Icon(iconData, color: _defaultColor),
        activeIcon: Icon(iconData, color: _activeColor));
  }
}
