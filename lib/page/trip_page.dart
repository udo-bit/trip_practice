import 'package:flutter/material.dart';
import 'package:trip_practice/dao/travel_dao.dart';
import 'package:trip_practice/model/travel_category_model.dart';
import 'package:trip_practice/page/trip_tab_page.dart';

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> with TickerProviderStateMixin {
  late TabController controller;
  List<TravelTab> tabs = [];

  get _tabBar {
    return TabBar(
      controller: controller,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      labelColor: Colors.black,
      indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(color: Color(0xff2fcfbb), width: 3)),
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: tabs.map<Tab>((TravelTab tab) {
        return Tab(
          text: tab.labelName,
        );
      }).toList(),
    );
  }

  get _tabBarView {
    return TabBarView(
        controller: controller,
        children: tabs.map((TravelTab tab) {
          return TripTabPage(groupChannelCode: tab.groupChannelCode);
        }).toList());
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 0, vsync: this);
    // 请求数据
    TravelDao.getCategory().then((TravelCategoryModel? model) {
      setState(() {
        controller =
            TabController(length: model?.tabs.length ?? 0, vsync: this);
        tabs = model?.tabs ?? [];
      });
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
        ),
        Flexible(child: _tabBarView)
      ],
    ));
  }
}
