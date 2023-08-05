import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import '../../custom widgets/my_text_field.dart';

class UserData extends StatefulWidget {
  const UserData(
      {super.key,
      required this.emailController,
      required this.passwordController});
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Center(child: Text("Account Info")),
          MyTextField(
            hint: 'Email',
            icon: Icons.email,
            controller: widget.emailController,
            validator:
                ValidationBuilder().email("Please enter a valid email").build(),
          ),
          MyTextField(
            hint: 'Password',
            icon: Icons.lock,
            obscureText: true,
            controller: widget.passwordController,

            // helperText: 'Password must be at least 6 characters',
          ),
        ],
      ),
    );
  }
}
