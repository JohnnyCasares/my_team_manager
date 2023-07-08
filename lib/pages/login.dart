import 'package:flutter/material.dart';
import 'package:my_team_manager/custom%20widgets/my_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("My Team Manager",),
            Spacer(),
            Image.asset('images/soccer_logo.png', scale: 2,),

            MyTextField(hint: 'User Name', icon: Icons.person,),
            MyTextField(hint: 'Password', icon: Icons.lock,obscureText: true, helperText: 'Password must be at least 6 characters',),

            ElevatedButton(onPressed: (){Navigator.of(context).popAndPushNamed('/mainPage');}, child: Text("Login")),

            Spacer(),

            Align(alignment: Alignment.bottomCenter, child:TextButton(onPressed: (){Navigator.of(context).pushNamed("/signUp");}, child: Text('Create an account')) ,)


          ],
        ),
      ),
    );
  }
}
