import 'package:flutter/material.dart';
import 'repository/auth_repository.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/vote_screen.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  final themeData = ThemeData(
    textTheme: TextTheme(
      headline: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: themeData,
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<bool>(
            stream: AuthRepository().authStatus(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) return SplashScreen();
              if (snapshot.data) return VoteScreen();
              return LoginScreen();
            }));
  }
}
