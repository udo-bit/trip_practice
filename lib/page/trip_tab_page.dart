import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trip_practice/dao/travel_dao.dart';
import 'package:trip_practice/model/travel_tab_model.dart';
import 'package:trip_practice/widget/travel_item_widget.dart';

class TripTabPage extends StatefulWidget {
  final String groupChannelCode;
  const TripTabPage({super.key, required this.groupChannelCode});

  @override
  State<TripTabPage> createState() => _TripTabPageState();
}

class _TripTabPageState extends State<TripTabPage> {
  String? content;
  int pageIndex = 1;
  final pageSize = 10;
  List<TravelItem> travelItems = [];
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        loadData(loadMore: true);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  get _gridView => MasonryGridView.count(
      controller: controller,
      crossAxisCount: 2,
      itemCount: travelItems.length,
      itemBuilder: (BuildContext context, int index) => TravelItemWidget(
            item: travelItems[index],
            index: index,
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: MediaQuery.removePadding(
            context: context, removeTop: true, child: _gridView),
      ),
    );
  }

  Future<void> loadData({bool loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    try {
      // 请求数据
      TravelTabModel? model = await TravelDao.getTravels(
          widget.groupChannelCode, pageIndex, pageSize);
      List<TravelItem> items = _filterItems(model?.list);
      if (items.isEmpty) {
        pageIndex--;
      }
      if (!loadMore) {
        setState(() {
          travelItems = items;
        });
      } else {
        setState(() {
          travelItems.addAll(items);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      if (loadMore) {
        pageIndex--;
      }
    }
  }

  List<TravelItem> _filterItems(List<TravelItem>? list) {
    if (list == null) return [];
    List<TravelItem> filterItems = [];
    for (var item in list) {
      if (item.article != null) {
        filterItems.add(item);
      }
    }
    return filterItems;
  }

  Future<void> _handleRefresh() async {
    await loadData();
    return;
  }
}
