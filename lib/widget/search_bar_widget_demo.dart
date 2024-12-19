import 'package:flutter/material.dart';

enum SearchBarType { home, homeLight, normal }

class SearchBarWidgetDemo extends StatefulWidget {
  final String? hint;
  final String? defaultText;
  final bool? hideLeft;
  final SearchBarType? searchBarType;
  final void Function()? leftButtonClick;
  final void Function()? rightButtonClick;
  final void Function()? inputBoxClick;
  final ValueChanged<String>? onChanged;

  const SearchBarWidgetDemo({
    super.key,
    this.hint = '请输入内容',
    this.defaultText = '北京欢迎你',
    this.hideLeft,
    this.leftButtonClick,
    this.rightButtonClick,
    this.inputBoxClick,
    this.onChanged,
    this.searchBarType = SearchBarType.normal,
  });

  @override
  State<SearchBarWidgetDemo> createState() => _SearchBarWidgetDemoState();
}

class _SearchBarWidgetDemoState extends State<SearchBarWidgetDemo> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();
  Widget get _normalSearchBar => Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 5, 10, 5),
            child: _wrapTap(_backBtn, widget.leftButtonClick),
          ),
          Expanded(child: _inputBox),
          _wrapTap(
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  '搜索',
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ),
              ),
              widget.rightButtonClick)
        ],
      );

  get _backBtn => widget.hideLeft ?? false
      ? null
      : const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 26);

  get _inputBox {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = const Color(0xffededed);
    }
    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: inputBoxColor,
          borderRadius: BorderRadius.circular(
              widget.searchBarType == SearchBarType.normal ? 5 : 15)),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal
                ? const Color(0xffa9a9a9)
                : Colors.blue,
          ),
          Expanded(child: _textField),
          if (showClear)
            _wrapTap(
                const Icon(
                  Icons.clear,
                  size: 22,
                  color: Colors.grey,
                ), () {
              _controller.clear();
              _onChanged("");
            })
        ],
      ),
    );
  }

  get _homeSearchBar => Row(
        children: [
          _wrapTap(
              Container(
                padding: const EdgeInsets.fromLTRB(6, 5, 5, 5),
                child: Row(children: [
                  Text(
                    '北京',
                    style: TextStyle(color: _homeFontColor, fontSize: 16),
                  ),
                  Icon(
                    Icons.expand_more,
                    color: _homeFontColor,
                    size: 22,
                  )
                ]),
              ),
              widget.leftButtonClick),
          Expanded(child: _inputBox),
          _wrapTap(
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text('登出',
                    style: TextStyle(color: _homeFontColor, fontSize: 16)),
              ),
              widget.rightButtonClick)
        ],
      );

  get _textField => widget.searchBarType == SearchBarType.normal
      ? TextField(
          autofocus: true,
          controller: _controller,
          onChanged: _onChanged,
          cursorColor: Colors.blue,
          cursorHeight: 20,
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w300),
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 5, bottom: 12, right: 5),
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle: const TextStyle(fontSize: 15)),
        )
      : _wrapTap(
          Text(
            widget.defaultText ?? "",
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          widget.inputBoxClick);

  get _homeFontColor => widget.searchBarType == SearchBarType.homeLight
      ? Colors.black54
      : Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.defaultText != null) {
      _controller.text = widget.defaultText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _normalSearchBar
        : _homeSearchBar;
  }

  _wrapTap(Widget child, void Function()? callback) {
    return GestureDetector(
      onTap: callback,
      child: child,
    );
  }

  void _onChanged(String value) {}
}
