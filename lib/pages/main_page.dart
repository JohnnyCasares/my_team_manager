import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_team_manager/custom%20widgets/main_layout.dart';
import 'package:my_team_manager/pages/my_players.dart';
import 'package:my_team_manager/pages/profile.dart';
import 'package:my_team_manager/pages/search.dart';

import '../custom widgets/models/users/user.dart';
import 'home.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AppUser player = AppUser(name: '');
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  int _selectedIndex = 0;

  //TODO: CREATE FUNCTIONS THAT FETCHES PLAYER DATA FROM FIREBASE
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersFireStore =
      FirebaseFirestore.instance.collection('users');

  void _fetchPlayerData() async {
    await _usersFireStore.doc(_auth.currentUser!.uid).get().then((value) {
      setState(() {
        try {
          player = AppUser(
              name: value['name'],
              position: Map<String, String>.from(value['position']),
              nfcUID: value['uid'],
              imageURL: value['imageUrl']);
        } on Exception catch (e) {
          // TODO
          player = AppUser(name: 'No name');
          print("Error in main_page.dart $e");
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPlayerData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const Home(),
      const MyPlayers(),
      const Search(),
      Profile(player: player)
    ];
    return MainLayout(
        body: IndexedStack(
          alignment: Alignment.bottomCenter,
          index: _selectedIndex,
          children: pages,
        ),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        labelType: labelType,
        title: "My Team Manager");
  }
}
