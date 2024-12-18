import 'package:flutter/material.dart';

import '../model/home_model.dart';

class GridNavWidgetDemo extends StatelessWidget {
  final GridNav gridNav;
  const GridNavWidgetDemo({super.key, required this.gridNav});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
      child: PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: _gridNavItems(context),
        ),
      ),
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
        margin: first ? const EdgeInsets.only(top: 3) : null,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [startColor, endColor])),
        child: Row(
          children: expandItems,
        ));
  }

  Widget _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.network(
              model.icon!,
              fit: BoxFit.contain,
            ),
            Container(
              margin: const EdgeInsets.only(top: 11),
              child: Text(
                model.title!,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            )
          ],
        ),
        model);
  }

  Widget _wrapGesture(BuildContext context, Widget child, CommonModel model) {
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
        Expanded(child: _item(context, bottomModel, false))
      ],
    );
  }

  _item(BuildContext context, CommonModel model, bool top) {
    BorderSide borderSide = const BorderSide(width: 0.8, color: Colors.white);
    return Container(
      decoration: BoxDecoration(
          border: Border(
              left: borderSide, bottom: top ? borderSide : BorderSide.none)),
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
