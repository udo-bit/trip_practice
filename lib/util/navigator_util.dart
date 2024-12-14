import 'package:flutter/material.dart';
import 'package:trip_practice/page/home_page.dart';
import 'package:trip_practice/page/login_page.dart';

class NavigatorUtil {
  static BuildContext? _context;
  static updateContext(BuildContext context) {
    _context = context;
  }

  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static goToHome(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  static goToLogin() {
    Navigator.pushReplacement(
        _context!, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}