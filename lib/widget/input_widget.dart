import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String hint;
  final bool obscure;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;

  const InputWidget(
      {super.key,
      required this.hint,
      this.textInputType = TextInputType.text,
      this.obscure = false,
      this.onChanged});

  get _input => TextField(
        obscureText: obscure,
        keyboardType: textInputType,
        onChanged: onChanged,
        autofocus: !obscure,
        cursorColor: Colors.white,
        style: const TextStyle(fontSize: 17, color: Colors.white),
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 17),
            border: InputBorder.none),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _input,
        const Divider(
          color: Colors.grey,
          thickness: 0.5,
          height: 1,
        )
      ],
    );
  }
}
