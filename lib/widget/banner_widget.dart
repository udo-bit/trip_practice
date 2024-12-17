import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trip_practice/model/home_model.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key, required this.lists});
  final List<CommonModel> lists;

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Stack(children: [
      CarouselSlider(
        carouselController: _controller,
        items: widget.lists.map((item) => _tableItems(item, width)).toList(),
        options: CarouselOptions(
          height: 200,
          viewportFraction: 1.0,
          autoPlay: true,
          onPageChanged: (int index, CarouselPageChangedReason reason) {
            setState(() {
              _current = index;
            });
          },
        ),
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 5,
        child: _indicator(),
      )
    ]);
  }

  Widget _tableItems(CommonModel item, double width) {
    return GestureDetector(
      onTap: () {
        //todo 跳转具体详情页
      },
      child: Image.network(
        item.icon!,
        fit: BoxFit.cover,
        width: width,
      ),
    );
  }

  _indicator() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.lists.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () {
              _controller.jumpToPage(entry.key);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Colors.white)
                      .withOpacity(entry.key == _current ? 0.9 : 0.4)),
            ),
          );
        }).toList());
  }
}
