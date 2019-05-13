import 'package:flutter/material.dart';
import './todoPage.dart';

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
        title: Text("My Friend"),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 15, 30, 0),
          children: <Widget>[
            Text(
              "${id.toString()} : ${name}",
              style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24)
            ),
            RaisedButton(
              child: Text("TODOS"),
              onPressed: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoPage(id: this.id),
                ),
              );
              },
            ),
            RaisedButton(
              child: Text("POST"),
            ),
            RaisedButton(
              child: Text("ALBUMS"),
            ),
            RaisedButton(
              child: Text("BACK"),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}