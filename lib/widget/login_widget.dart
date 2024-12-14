import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  final bool enable;
  final String title;
  final VoidCallback? onPressed;
  const LoginWidget(
      {super.key, this.enable = true, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: Colors.teal,
      disabledColor: Colors.blueGrey,
      height: 40,
      onPressed: enable ? onPressed : null,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
