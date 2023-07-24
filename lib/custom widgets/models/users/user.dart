import 'package:flutter/material.dart';

class AppUser {
  String name;
  Map<String, String>? position;
  List? teams;
  String? imageURL;
  String? nfcUID;
  AppUser(
      {required this.name,
      this.position,
      this.teams,
      this.nfcUID,
      this.imageURL});
}

class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.userData});
  final AppUser userData;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  List<String>? positionList;
  String? positionText;


  @override
  Widget build(BuildContext context) {

    if (widget.userData.position != null) {
      positionList = widget.userData.position!.keys.toList();
      positionText = positionList.toString();
      positionText = positionText!.substring(1, positionText!.length - 1);

    }

    return Card(
      child: Column(
        children: [
          widget.userData.imageURL != null
              ? Image.network(widget.userData.imageURL!)
              : const SizedBox(), //TODO: change sized box to default icon svg in images/assets
          Text(widget.userData.name),
          Text(positionText ?? 'No preferred position'),
          Text(widget.userData.nfcUID ?? 'Get an NFC tag'),
          //TODO: DISPLAY TEAMS
        ],
      ),
    );
  }
}
