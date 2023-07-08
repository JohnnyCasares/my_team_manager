import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_team_manager/navigation/route_generator.dart';
import 'package:my_team_manager/pages/login.dart';
import 'package:my_team_manager/pages/main_page.dart';
import 'package:my_team_manager/theme/color_schemes.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: TeamManagerTheme.lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: TeamManagerTheme.darkColorScheme),
      title: 'Flutter Demo',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,

      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return const MainPage();
          } else {
            return const Login();
          }
        }),
      ),
    );
  }
}
