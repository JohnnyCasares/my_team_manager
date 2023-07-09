import 'package:flutter/material.dart';
import 'package:my_team_manager/custom%20widgets/my_text_field.dart';

import '../constants/soccer.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: Center(
        child: Column(
          children: [
            //Add image field
            const MyTextField(
              hint: 'Enter your name',
              icon: Icons.text_fields,
            ),
            MyTextField(
              hint: 'Select your prefered position',
              icon: Icons.directions_run,
              readOnly: true,
              function: () async{
                showDialog(context: context,
                    builder: (BuildContext context){
                      return const PositionMultiSelect();
                    });
                FocusScope.of(context).unfocus();
              },
            ),
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
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Choose your preferred position'),
                  const SizedBox(height: 15),
                  PositionSelect(positionTitle:'Attack',positionOptions: Soccer.attack),
                  Divider(),
                  PositionSelect(positionTitle:'Midfield',positionOptions: Soccer.midField),
                  Divider(),
                  PositionSelect(positionTitle:'Defense',positionOptions: Soccer.defense)


                ],
              ),
            ),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PositionItem extends StatelessWidget {
  const PositionItem({super.key, required this.position});
  final String position;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(position),
      ),
    );
  }
}
class PositionTitle extends StatelessWidget {
  const PositionTitle({super.key, required this.positionTitle});
  final String positionTitle;
  @override
  Widget build(BuildContext context) {
    return  Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child:
          Text(positionTitle),
        )
    );
  }
}


class PositionSelect extends StatefulWidget {
  const PositionSelect({super.key, required this.positionOptions, required this.positionTitle});
  final String positionTitle;
  final Map<String, String> positionOptions;

  @override
  State<PositionSelect> createState() => _PositionSelectState();
}

class _PositionSelectState extends State<PositionSelect> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: PositionTitle(positionTitle: widget.positionTitle),
        ),

        Expanded(
          child: Wrap(

            children:

              List<Widget>.generate(widget.positionOptions.keys.length, (index) {
                final key = widget.positionOptions.keys.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PositionItem(position: key),
                );
              }),

          ),
        ),
      ],
    );
  }
}



