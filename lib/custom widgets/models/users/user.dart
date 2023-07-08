import 'package:flutter/material.dart';
class AppUser {
  String name;
  String? position;
  List? teams;
  String imageURL;
  String? nfcUID;
  AppUser({required this.name, this.position, this.teams, this.nfcUID, required this.imageURL});
}

class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.userData});
  final AppUser userData;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(widget.userData.imageURL),
          Text(widget.userData.name),
          Text(widget.userData.position??'No preferred position'),
          Text(widget.userData.nfcUID??'Get an NFC tag'),
          //TODO: DISPLAY TEAMS

        ],
      ),
    );






  }
}



