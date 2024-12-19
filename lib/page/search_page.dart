import 'package:flutter/material.dart';
import 'package:trip_practice/util/navigator_util.dart';
import 'package:trip_practice/widget/search_bar_widget_demo.dart';

class SearchPage extends StatefulWidget {
  final bool? hideLeft;
  const SearchPage({super.key, this.hideLeft = false});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        SearchBarWidgetDemo(
          hideLeft: widget.hideLeft,
          leftButtonClick: () => NavigatorUtil.pop(context),
        ),
      ],
    ));
  }
}
