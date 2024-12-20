import 'package:flutter/material.dart';
import 'package:trip_practice/dao/home_dao.dart';
import 'package:trip_practice/dao/login_dao.dart';
import 'package:trip_practice/model/home_model.dart';
import 'package:trip_practice/page/search_page.dart';
import 'package:trip_practice/util/navigator_util.dart';
import 'package:trip_practice/widget/banner_widget.dart';
import 'package:trip_practice/widget/local_nav_widget.dart';
import 'package:trip_practice/widget/sales_box_widget.dart';
import 'package:trip_practice/widget/sub_nav_widget.dart';

import '../widget/grid_nav_widget.dart';
import '../widget/search_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static Config? configModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  double appBarAlpha = 0;
  static const appBarScrollOffset = 100;
  List<CommonModel> bannerListModel = [];
  List<CommonModel> localNavListModel = [];
  List<CommonModel> subNavListModel = [];
  GridNav? gridNavModel;
  SalesBox? salesBoxModel;
  bool _loading = true;

  get _logout {
    return ElevatedButton(
        onPressed: () {
          LoginDao.logout();
        },
        child: const Text('登出'));
  }

  get _contentView => MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollNotification && notification.depth == 0) {
              _onScroll(notification.metrics.pixels);
            }
            return false;
          },
          child: _listView,
        ),
      ));

  get _listView => ListView(
        children: [
          BannerWidget(lists: bannerListModel),
          LocalNavWidget(localNavList: localNavListModel),
          if (gridNavModel != null) GridNavWidget(gridNav: gridNavModel!),
          SubNavWidget(subNavList: subNavListModel),
          if (salesBoxModel != null) SalesBoxWidget(salesBox: salesBoxModel!)
        ],
      );

  get _appBar {
    double top = MediaQuery.of(context).padding.top;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: top),
          height: 60 + top,
          decoration: BoxDecoration(
              color:
                  Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)),
          child: SearchBarWidget(
            searchBarType: appBarAlpha > 0.2
                ? SearchBarType.homeLight
                : SearchBarType.home,
            inputBoxClick: _jumpToSearch,
            defaultText: '北京欢迎你',
            rightButtonClick: () {
              LoginDao.logout();
            },
          ),
        ),
      ],
    );
  }

  void _jumpToSearch() {
    NavigatorUtil.push(
        context,
        const SearchPage(
          keyword: '北京',
          hideLeft: false,
        ));
  }

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: Stack(
          children: [_contentView, _appBar],
        ));
  }

  Future<void> _handleRefresh() async {
    try {
      HomeModel homeModel = await HomeDao.fetch();
      setState(() {
        HomePage.configModel = homeModel.config;
        bannerListModel = homeModel.bannerList ?? [];
        localNavListModel = homeModel.localNavList ?? [];
        subNavListModel = homeModel.subNavList ?? [];
        gridNavModel = homeModel.gridNav;
        salesBoxModel = homeModel.salesBox;
        _loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _loading = false;
      });
    }
  }

  void _onScroll(double pixels) {
    double alpha = pixels / appBarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
