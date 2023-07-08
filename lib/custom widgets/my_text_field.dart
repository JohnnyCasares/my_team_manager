import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField(
      {super.key,
      required this.hint,
      this.controller,
      this.icon,
      this.obscureText,
      this.helperText});

  final String hint;
  final TextEditingController? controller;
  final IconData? icon;
  final bool? obscureText;
  final String? helperText;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: widget.hint,
              prefixIcon: Icon(widget.icon),
              helperText: widget.helperText,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)))),

          obscureText: widget.obscureText ?? false,
          controller: widget.controller,
        ));
  }
}
