import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:my_team_manager/custom%20widgets/my_text_field.dart';
import 'package:my_team_manager/services/firebase_services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
// Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _body(),
        ),
      ),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Text(
                "My Team Manager",
              ),
            ),
            // const Spacer(),
            Image.asset(
              'assets/images/soccer_logo.png',
              width: 150, // Adjust the width of the image to your desired size
              height:
                  150, // Adjust the height of the image to your desired size
            ),
            MyTextField(
              hint: 'Email',
              icon: Icons.mail,
              controller: emailController,
              validator: ValidationBuilder()
                  .email("Please enter a valid email")
                  .build(),
            ),
            MyTextField(
              hint: 'Password',
              icon: Icons.lock,
              obscureText: true,
              controller: passwordController,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 700,
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await Authentication.signIn(
                            emailController.text, passwordController.text);
                      }
                    },
                    child: const Text("Login")),
              ),
            ),
            // const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/signUp");
                  },
                  child: const Text('Create an account')),
            ),
            // const Spacer(),
          ],
        ),
      ),
    );
  }
}
