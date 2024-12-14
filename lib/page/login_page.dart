import 'package:flutter/material.dart';
import 'package:trip_practice/util/view_util.dart';
import 'package:trip_practice/widget/input_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _username;
  String? _password;
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
            },
          ),
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
}
