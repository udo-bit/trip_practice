import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trip_practice/util/navigator_util.dart';

import '../dao/search_dao.dart';
import '../model/search_model.dart';
import '../widget/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  final bool? hideLeft;
  final String? keyword;
  final String? hint;
  const SearchPage({super.key, this.hideLeft = false, this.keyword, this.hint});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel? searchModel;
  String? keyword;
  get _appBar {
    double top = MediaQuery.of(context).padding.top;
    return Container(
      height: 55 + top,
      decoration: const BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(top: top),
      child: SearchBarWidget(
        hideLeft: widget.hideLeft,
        defaultText: widget.keyword,
        hint: widget.hint,
        leftButtonClick: () => NavigatorUtil.pop(context),
        rightButtonClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onChanged: _onTextChange,
      ),
    );
  }

  get _listView {
    return ListView(
      children: [Text(jsonEncode(searchModel))],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [_appBar, _listView],
      ),
    );
  }

  void _onTextChange(String value) async {
    try {
      var result = await SearchDao.fetch(value);
      if (result == null) return;
      if (result.keyword == value) {
        setState(() {
          searchModel = result;
        });
      }
      debugPrint(searchModel.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _item(int index) {
    var item = searchModel?.data?[index];
    if (item == null || searchModel == null) return Container();
    return Text(item.toString());
  }
}
