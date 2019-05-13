import 'package:flutter/material.dart';
import '../utils/currentUser.dart';
import 'package:flutter_prepared/db/userDB.dart';


class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }

}

class ProfilePageState extends State<ProfilePage>{
  final _formkey = GlobalKey<FormState>();

  UserUtils user = UserUtils();
  final userid = TextEditingController(text: CurrentUser.USERID);
  final name = TextEditingController(text: CurrentUser.NAME);
  final age = TextEditingController(text: CurrentUser.AGE);
  final password = TextEditingController();
  final quote = TextEditingController(text: CurrentUser.QUOTE);

  bool isUserIn = false;

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  int countSpace(String s){
    int result = 0;
    for(int i = 0;i<s.length;i++){
      if(s[i] == ' '){
        result += 1;
      }
    }
    return result;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Setup"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 15, 30, 0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "User Id",
                hintText: "User Id must be between 6 to 12",
                icon: Icon(Icons.account_box, size: 40, color: Colors.grey),
              ),
              controller: userid,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please fill out this form";
                }
                else if (isUserIn){
                  print("hey");
                  return "This Username is taken";
                }
                else if (value.length < 6 || value.length > 12){
                  return "Please fill UserId Correctly";
                }
              }
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Name",
                hintText: "ex. 'John Snow'",
                icon: Icon(Icons.account_circle, size: 40, color: Colors.grey),
              ),
              controller: name,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please fill out this form";
                }
                else if(countSpace(value) != 1){
                  return "Please fill Name Correctly";
                }
              }
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Age",
                hintText: "Please fill Age Between 10 to 80",
                icon: Icon(Icons.event_note, size: 40, color: Colors.grey),
              ),
              controller: age,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please fill Age";
                }
                else if (!isNumeric(value) || int.parse(value) < 10 || int.parse(value) > 80) {
                  return "Please fill Age correctly";
                }
              }
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Password must be longer than 6",
                icon: Icon(Icons.lock, size: 40, color: Colors.grey),
              ),
              controller: password,
              obscureText: true,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty || value.length <= 6) {
                  return "Please fill Password Correctly";
                }
              }
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Quote",
                hintText: "Explain you self!",
                icon: Icon(Icons.settings_system_daydream, size: 40, color: Colors.grey),
              ),
              controller: quote,
              keyboardType: TextInputType.text,
              maxLines: 5
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10)),
            RaisedButton(
              child: Text("SAVE"),
              onPressed: () async {
                await user.open("user.db");
                Future<List<User>> allUser = user.getAllUser();
                User userData = User();
                userData.id = CurrentUser.ID;
                userData.userid = userid.text;
                userData.name = name.text;
                userData.age = age.text;
                userData.password = password.text;
                userData.quote = quote.text;
                //function to check if user in
                Future isUserTaken(User user) async {
                  var userList = await allUser;
                  for(var i=0; i < userList.length;i++){
                    if (user.userid == userList[i].userid && CurrentUser.ID != userList[i].id){
                      print('Taken');
                      this.isUserIn = true;
                      break;
                    }
                  }
                }
                //validate form
                if (_formkey.currentState.validate()){
                  await isUserTaken(userData);
                  print(this.isUserIn);
                  //if user not exist
                  if(!this.isUserIn) {
                    await user.updateUser(userData);
                    CurrentUser.USERID = userData.userid;
                    CurrentUser.NAME = userData.name;
                    CurrentUser.AGE = userData.age;
                    CurrentUser.PASSWORD = userData.password;
                    CurrentUser.QUOTE = userData.quote;
                    Navigator.pop(context);
                    print('insert complete');
                  }
                }

                this.isUserIn = false;
                Future showAllUser() async {
                  var userList = await allUser;
                  for(var i=0; i < userList.length;i++){
                    print(userList[i]);
                    }
                  }

                showAllUser();
                print(CurrentUser.whoCurrent());
              }
            ),
          ]
        ),
      )
    );
  }

}