import 'package:flutter/material.dart';

import '../model/home_model.dart';

class GridNavWidgetDemoV2 extends StatelessWidget {
  final GridNav gridNav;
  const GridNavWidgetDemoV2({super.key, required this.gridNav});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
      child: PhysicalModel(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          child: Column(
            children: _gridNavItems(context),
          )),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    items.add(_gridNavItem(context, gridNav.hotel!, true));
    items.add(_gridNavItem(context, gridNav.flight!, false));
    items.add(_gridNavItem(context, gridNav.travel!, false));
    return items;
  }

  Widget _gridNavItem(BuildContext context, Hotel child, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, child.mainItem!));
    items.add(_doubleItem(context, child.item1!, child.item2!));
    items.add(_doubleItem(context, child.item3!, child.item4!));
    List<Widget> expandItems = [];
    for (var item in items) {
      expandItems.add(Expanded(
        flex: 1,
        child: item,
      ));
    }
    Color startColor = Color(int.parse('0xff${child.startColor}'));
    Color endColor = Color(int.parse('0xff${child.endColor}'));
    return Container(
      height: 88,
      margin: first ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(
        children: expandItems,
      ),
    );
  }

  Widget _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.network(model.icon!, fit: BoxFit.contain),
            Container(
              margin: const EdgeInsets.only(top: 11),
              child: Text(
                model.title!,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        model);
  }

  _wrapGesture(BuildContext context, Widget child, CommonModel model) {
    return GestureDetector(
      onTap: () {},
      child: child,
    );
  }

  Widget _doubleItem(
      BuildContext context, CommonModel topModel, CommonModel bottomModel) {
    return Column(
      children: [
        Expanded(child: _item(context, topModel, true)),
        Expanded(child: _item(context, bottomModel, false)),
      ],
    );
  }

  _item(BuildContext context, CommonModel model, bool first) {
    BorderSide borderSide = const BorderSide(color: Colors.white, width: 0.8);
    return Container(
      decoration: BoxDecoration(
          border: Border(
              left: borderSide, bottom: first ? borderSide : BorderSide.none)),
      child: _wrapGesture(
          context,
          Center(
            child: Text(
              model.title!,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          model),
    );
  }
}
