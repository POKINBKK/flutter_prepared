import 'package:flutter/material.dart';
import './ui/registerPage.dart';
import './ui/loginPage.dart';
import './ui/homePage.dart';
import './ui/profilePage.dart';
import './ui/friendPage.dart';

void main() => runApp(MyApp());

const PrimaryColor = const Color(0xFFff6337);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Prepared',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/home": (context) => HomePage(),
        "/profile": (context) => ProfilePage(),
        "/friend": (context) => FriendPage(),
      },
    );
  }
}
