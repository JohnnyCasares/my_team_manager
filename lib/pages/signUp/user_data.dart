import 'package:flutter/material.dart';

import '../../custom widgets/my_text_field.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("Registration Info"),
        MyTextField(
          hint: 'Email',
          icon: Icons.email,
        ),
        MyTextField(
          hint: 'Password',
          icon: Icons.lock,
          obscureText: true,
          // helperText: 'Password must be at least 6 characters',
        ),

      ],
    );
  }
}
