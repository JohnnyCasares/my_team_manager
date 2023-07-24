import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.hint,
    this.controller,
    this.icon,
    this.obscureText,
    this.helperText,
    this.function,
    this.readOnly,
    this.validator,
  });

  final String hint;
  final TextEditingController? controller;
  final IconData? icon;
  final bool? obscureText;
  final String? helperText;
  final Function()? function;
  final bool?
      readOnly; //Allows textfield to be clickable, but not editable by user
  final String? Function(String?)? validator;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  // Initially password is obscure
  late bool _obscureText;
  late IconData _viewTextObscured;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.obscureText != null) {
      _obscureText = widget.obscureText!;
    } else {
      _obscureText = false;
    }

    if (_obscureText) {
      _viewTextObscured = Icons.visibility;
    } else {
      _viewTextObscured = Icons.visibility_off;
    }
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText) {
        _viewTextObscured = Icons.visibility;
      } else {
        _viewTextObscured = Icons.visibility_off;
      }
    });
  }

  // Default validator function
  String? defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final validator = widget.validator ?? defaultValidator;
    return Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: 700,
          child: TextFormField(
              readOnly: widget.readOnly ?? false,
              onTap: widget.function,
              decoration: InputDecoration(
                  hintText: widget.hint,
                  prefixIcon: Icon(widget.icon),
                  suffixIcon: widget.obscureText != null
                      ? IconButton(
                          onPressed: _toggle, icon: Icon(_viewTextObscured))
                      : null,
                  helperText: widget.helperText,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
              obscureText: _obscureText,
              controller: widget.controller,
              validator: validator),
        ));
  }
}
// IconButton(onPressed: (){}, icon: const Icon(Icons.remove_red_eye)
