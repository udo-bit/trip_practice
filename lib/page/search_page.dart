import 'package:flutter/material.dart';
import 'package:trip_practice/widget/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: const [
        SearchBarWidget(
          searchBarType: SearchBarType.normal,
        ),
        SearchBarWidget(
          searchBarType: SearchBarType.home,
        ),
        SearchBarWidget(
          searchBarType: SearchBarType.homeLight,
        )
      ],
    ));
  }
}
