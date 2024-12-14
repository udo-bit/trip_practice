import 'package:flutter/material.dart';
import 'package:trip_practice/dao/login_dao.dart';
import 'package:trip_practice/util/func_util.dart';
import 'package:trip_practice/util/navigator_util.dart';
import 'package:trip_practice/util/view_util.dart';
import 'package:trip_practice/widget/input_widget.dart';
import 'package:trip_practice/widget/login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _username;
  String? _password;
  bool enabled = false;
  get _bg => <Widget>[
        Positioned.fill(
          child: Image.asset(
            "assets/images/loop_video.gif",
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
            child: Container(
          color: Colors.black12,
        )),
      ];

  get _content => Positioned.fill(
      left: 30,
      right: 30,
      child: ListView(
        children: [
          hiHeight(height: 150),
          const Text(
            '用户名和密码登陆',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          hiHeight(height: 30),
          InputWidget(
            hint: "请输入用户名",
            onChanged: (text) {
              setState(() {
                _username = text;
                _validInput();
              });
            },
          ),
          hiHeight(height: 10),
          InputWidget(
            hint: "请输入密码",
            obscure: true,
            textInputType: TextInputType.number,
            onChanged: (text) {
              _password = text;
              _validInput();
            },
          ),
          hiHeight(height: 15),
          LoginWidget(
            enable: enabled,
            title: "登陆",
            onPressed: () {
              _login(context);
            },
          )
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [..._bg, _content],
        ));
  }

  void _validInput() {
    bool btnState = false;
    if (isNotEmpty(_username) && isNotEmpty(_password)) {
      btnState = true;
    } else {
      btnState = false;
    }
    setState(() {
      enabled = btnState;
    });
  }

  void _login(BuildContext context) async {
    try {
      var response =
          await LoginDao.login(username: _username!, password: _password!);
      debugPrint('登陆成功');
      //跳转首页
      context.mounted ? NavigatorUtil.goToHome(context) : null;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
