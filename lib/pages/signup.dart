import 'package:flutter/material.dart';
import 'package:my_team_manager/custom%20widgets/my_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create account')),
      body:Center(
        child: Column(
          children: [
            //Add image field
            MyTextField(hint: 'Enter your name', icon: Icons.text_fields,),
            MyTextField(hint: 'Select your prefered position', icon: Icons.directions_run,),



          ],
        ),
      ),
    );
  }
}



class PositionMultiSelect extends StatefulWidget {
  const PositionMultiSelect({super.key});

  @override
  State<PositionMultiSelect> createState() => _PositionMultiSelectState();
}

class _PositionMultiSelectState extends State<PositionMultiSelect> {
  @override
  Widget build(BuildContext context) {
    //popup dialog box 
    return Text("Hey");
  }
}


