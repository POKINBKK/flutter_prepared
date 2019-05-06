import 'package:flutter/material.dart';
import 'package:flutter_prepared/db/userDB.dart';


class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }

}

class RegisterPageState extends State<RegisterPage>{
  final _formkey = GlobalKey<FormState>();
  UserUtils user = UserUtils();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final username = TextEditingController();
  final password1 = TextEditingController();
  final password2 = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  bool isUserIn = false;

  bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register New User"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 15, 30, 0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Firstname",
                hintText: "Please Input Your Firstname",
                icon: Icon(Icons.account_circle, size: 40, color: Colors.orange),
              ),
              controller: firstname,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please fill Firstname";
                }
              }
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Lastname",
                icon: Icon(Icons.account_circle, size: 40, color: Colors.orange),
              ),
              controller: lastname,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please fill Lastname";
                }
              }
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Email",
                icon: Icon(Icons.email, size: 40, color: Colors.orange),
              ),
              controller: email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please fill Email";
                } 
                else if (!value.contains('@')) {
                  return "Please fill valid Email";
                }
              }
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Phone",
                icon: Icon(Icons.phone, size: 40, color: Colors.orange),
              ),
              controller: phone,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please fill Phone number";
                }
                else if (!isNumeric(value)) {
                  return "Please fill Phone number correctly";
                }
              }
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Username",
                icon: Icon(Icons.account_circle, size: 40, color: Colors.orange),
              ),
              controller: username,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please fill Username";
                }
                else if (this.isUserIn){
                  return "This Username is taken";
                }
              }
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Password",
                icon: Icon(Icons.lock, size: 40, color: Colors.orange),
              ),
              controller: password1,
              obscureText: true,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty || value.length < 8) {
                  return "Please fill Password Correctly";
                }
              }
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Confirm Password",
                icon: Icon(Icons.lock, size: 40, color: Colors.orange),
              ),
              controller: password2,
              obscureText: true,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty || value != password1.text) {
                  return "Please fill Password as above";
                }
              }
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10)),
            RaisedButton(
              child: Text("Save"),
              onPressed: () async {
                await user.open("user.db");
                Future<List<User>> allUser = user.getAllUser();
                User userData = User();
                userData.firstname = firstname.text;
                userData.lastname = lastname.text;
                userData.email = email.text;
                userData.phone = phone.text;
                userData.username = username.text;
                userData.password = password1.text;

                print("userdata : ${userData}");

                //function to check if user in
                Future isNewUserIn(User user) async{
                  var userList = await allUser;
                  for(var i=0; i < userList.length;i++){
                    print(userList[i]);
                    if (user.username == userList[i].username){
                      this.isUserIn = true;
                      break;
                    }
                  }
                }

                //call function
                await isNewUserIn(userData);
                print(this.isUserIn);

                //validate form
                _formkey.currentState.validate();

                //insert if it can but it's bugs now
                if(!this.isUserIn) {
                  await user.insertUser(userData);
                  print('insert complete');
                }
                this.isUserIn = false;

                //print("${allUserResult}, ${userData}");
                
                // if(firstname.text.length > 0){
                //await user.insertUser(userData);
                //   print(userData);
                //   print('insert complete');
                //   Navigator.pop(context);
                // }
                // firstname.text = "";
                // lastname.text = "";
                // email.text = "";
                // phone.text = "";
                // username.text = "";
                // password1.text = "";
                // password2.text = "";
              },
            ),
          ],
        ),
      ),
    );
  }
}