import 'package:flutter/material.dart';
import './ui/registerPage.dart';
import './ui/loginPage.dart';
import './ui/homePage.dart';
import './ui/profilePage.dart';
import './ui/myfriendPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Prepared',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/home": (context) => HomePage(),
        "/profile": (context) => ProfilePage(),
        "/myfriend": (context) => MyfriendPage(),
      },
    );
  }
}
