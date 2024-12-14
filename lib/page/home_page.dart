import 'package:flutter/material.dart';
import 'package:trip_practice/dao/login_dao.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: const Text('首页'),
    );
  }
}
