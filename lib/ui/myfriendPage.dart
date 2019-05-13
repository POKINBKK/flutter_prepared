import 'package:flutter/material.dart';

class MyfriendPage extends StatelessWidget {
  // Declare a field that holds the Todo
  final int id;
  final String name;
  // In the constructor, require a Todo
  MyfriendPage({Key key, @required this.id, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return Scaffold(
      appBar: AppBar(
        title: Text("${id.toString()} : ${name}"),
      ),
    );
  }
}