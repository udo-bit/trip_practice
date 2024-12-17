import 'package:flutter/material.dart';
import 'package:trip_practice/dao/login_dao.dart';
import 'package:trip_practice/widget/banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> lists = [
    "https://img1.baidu.com/it/u=2311996924,724373457&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=313",
    "https://img0.baidu.com/it/u=778214893,3396635396&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=338",
    "https://img2.baidu.com/it/u=152996483,2513007285&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
    "https://img0.baidu.com/it/u=2942798871,4064395557&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
  ];

  get _logout {
    return ElevatedButton(
        onPressed: () {
          LoginDao.logout();
        },
        child: const Text('登出'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("首页"),
          actions: [_logout],
        ),
        body: BannerWidget(
          lists: lists,
        ));
  }
}
