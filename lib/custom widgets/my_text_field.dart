import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField(
      {super.key,
      required this.hint,
      this.controller,
      this.icon,
      this.obscureText,
      this.helperText, this.function, this.readOnly});

  final String hint;
  final TextEditingController? controller;
  final IconData? icon;
  final bool? obscureText;
  final String? helperText;
  final Function()? function;
  final bool? readOnly; //Allows textfield to be clickable, but not editable by user

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          readOnly: widget.readOnly??false,
          onTap: widget.function ,
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
