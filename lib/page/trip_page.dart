import 'package:flutter/material.dart';

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  get _tabBar {
    return const Placeholder();
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 0, vsync: this);
    // 请求数据
  }

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    return Scaffold(
        body: Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: top),
          child: _tabBar,
        )
      ],
    ));
  }
}
