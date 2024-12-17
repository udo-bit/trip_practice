import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trip_practice/dao/home_dao.dart';
import 'package:trip_practice/dao/login_dao.dart';
import 'package:trip_practice/model/home_model.dart';
import 'package:trip_practice/widget/banner_widget.dart';
import 'package:trip_practice/widget/local_nav_widget.dart';

import '../widget/grid_nav_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static Config? configModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String content = "";
  final List<String> lists = [
    "https://img1.baidu.com/it/u=2311996924,724373457&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=313",
    "https://img0.baidu.com/it/u=778214893,3396635396&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=338",
    "https://img2.baidu.com/it/u=152996483,2513007285&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
    "https://img0.baidu.com/it/u=2942798871,4064395557&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
  ];
  double appBarAlpha = 0;
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

  get _contentView => _listView;

  get _listView => ListView(
        children: [
          BannerWidget(lists: bannerListModel),
          LocalNavWidget(localNavList: localNavListModel),
          if (gridNavModel != null) GridNavWidget(gridNav: gridNavModel!),
        ],
      );

  get _appBar {
    double top = MediaQuery.of(context).padding.top;
    return const Column(
      children: [],
    );
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
          children: [_contentView],
        ));
  }

  void _handleRefresh() async {
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
        content = jsonEncode(bannerListModel);
        debugPrint(content);
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _loading = false;
      });
    }
  }
}
