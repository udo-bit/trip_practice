import 'package:flutter/material.dart';
import 'package:trip_practice/dao/travel_dao.dart';

import '../model/travel_category_model.dart';

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  List<TravelTab> tabs = [];

  get _tabBar {
    return const Placeholder();
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 0, vsync: this);
    // 请求数据
    TravelDao.getCategory().then((TravelCategoryModel? model) {
      controller = TabController(length: model?.tabs.length ?? 0, vsync: this);
    });
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
