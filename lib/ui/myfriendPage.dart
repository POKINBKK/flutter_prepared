import 'package:flutter/material.dart';
import '../utils/currentUser.dart';


class MyfriendPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyfriendPageState();
  }

}

class MyfriendPageState extends State<MyfriendPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Friends"),
      ),
    );
  }

}