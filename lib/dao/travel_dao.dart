import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trip_practice/dao/header_util.dart';
import 'package:trip_practice/util/navigator_util.dart';

import '../model/travel_category_model.dart';

class TravelDao {
  static Future<TravelCategoryModel?> getCategory() async {
    var url = Uri.parse('https://api.geekailab.com/uapi/ft/category');
    final response = await http.get(url, headers: hiHeader());
    Utf8Decoder utf8decoder = const Utf8Decoder();
    var bodyString = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      var result = json.decode(bodyString);
      return TravelCategoryModel.fromJson(result);
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
        return null;
      }
    }
    throw Exception(bodyString);
  }
}
