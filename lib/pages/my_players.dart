import 'package:flutter/widgets.dart';

class MyPlayers extends StatefulWidget {
  const MyPlayers({super.key});

  @override
  State<MyPlayers> createState() => _MyPlayersState();
}

class _MyPlayersState extends State<MyPlayers> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("My Players"),);
  }
}
