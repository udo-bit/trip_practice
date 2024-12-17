import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:trip_practice/dao/header_util.dart';
import 'package:trip_practice/util/navigator_util.dart';

import '../model/home_model.dart';

class HomeDao {
  static Future<HomeModel> fetch() async {
    var uri = Uri.parse('http://api.geekailab.com/uapi/ft/home');
    var response = await http.get(uri, headers: hiHeader());
    Utf8Decoder utf8decoder = const Utf8Decoder();
    var bodyString = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      var map = json.decode(bodyString);
      return HomeModel.fromJson(map['data']);
    } else {
      if (response.statusCode == 401) {
        // 返回登录页
        NavigatorUtil.goToLogin();
      }
      throw Exception(bodyString);
    }
  }
}
