import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/travel_tab_model.dart';

class TravelItemWidget extends StatelessWidget {
  final TravelItem item;
  final int? index;
  const TravelItemWidget({super.key, required this.item, this.index});

  get _title => Container(
        padding: const EdgeInsets.all(4),
        child: Text(
          item.article?.articleTitle ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      );

  get _infoText => Container(
        padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_avatarNickName, _likeIcon],
        ),
      );

  get _avatarNickName => Row(
        children: [
          PhysicalModel(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              item.article?.author?.coverImage?.dynamicUrl ?? "",
              width: 24,
              height: 24,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            width: 90,
            child: Text(
              item.article?.author?.nickName ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          )
        ],
      );

  get _likeIcon => Row(
        children: [
          const Icon(
            Icons.thumb_up,
            size: 14,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(
              item.article?.likeCount.toString() ?? "",
              style: const TextStyle(fontSize: 10),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //todo 跳转h5
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_itemImage(context), _title, _infoText],
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
            constraints: BoxConstraints(minHeight: size.width / 2 - 10),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: item.article?.images?[0].dynamicUrl ?? "",
              fit: BoxFit.cover,
            )),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                LimitedBox(
                  maxWidth: 130,
                  child: Text(
                    _poiName(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  String _poiName() {
    return item.article?.pois == null || item.article!.pois!.isEmpty
        ? '未知'
        : item.article?.pois?[0].poiName ?? '未知';
  }
}
