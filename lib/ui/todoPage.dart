import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  // Declare a field that holds the Todo
  final int id;
  // In the constructor, require a Todo
  TodoPage({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 15, 30, 0),
          children: <Widget>[
            RaisedButton(
              child: Text("BACK"),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            
          ],
        ),
      ),
    );
  }
}