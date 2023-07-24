import 'package:flutter/material.dart';
import 'package:my_team_manager/custom%20widgets/models/users/user.dart';
import 'package:my_team_manager/services/firebase_services.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.player});
  final AppUser player;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('player name ${widget.player.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserItem(userData: widget.player), //TODO RECEIVE USERDATA OR FETCH FROM FIREBASE
        ElevatedButton(
            onPressed: () {
              Authentication.signOut();
            },
            child: Text('Sign out')),
      ],
    );
  }
}
