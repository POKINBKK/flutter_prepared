import 'package:sqflite/sqflite.dart';

final String userTable = "user";
final String idColumn = "_id";
final String firstnameColumn = "firstname";
final String lastnameColumn = "lastname";
final String usernameColumn = "username";
final String passwordColumn = "password";
final String phoneColumn = "phone";
final String emailColumn = "email";

class User {
  int id;
  String firstname;
  String lastname;
  String username;
  String password;
  String phone;
  String email;

  User();

  User.formMap(Map<String, dynamic> map) {
    this.id = map[idColumn];
    this.firstname = map[firstnameColumn];
    this.lastname = map[lastnameColumn];
    this.username = map[usernameColumn];
    this.password = map[passwordColumn];
    this.phone = map[phoneColumn];
    this.email = map[emailColumn];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      firstnameColumn: firstname,
      lastnameColumn: lastname,
      usernameColumn: username,
      passwordColumn: password,
      phoneColumn: phone,
      emailColumn: email
    };
    if (id != null) {
      map[idColumn] = id; 
    }
    return map;
  }

  @override
  String toString() { return 'id = ${this.id}, firstname =  ${this.firstname}, lastname =  ${this.lastname}, username =  ${this.username}, password =  ${this.password}, phone =  ${this.phone}, email =  ${this.email}'; }

}

class UserUtils {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table $userTable (
        $idColumn integer primary key autoincrement,
        $firstnameColumn text not null,
        $lastnameColumn text not null,
        $usernameColumn text not null unique,
        $passwordColumn text not null,
        $phoneColumn text not null,
        $emailColumn text not null,
      )
      ''');
    });
  }

  Future<User> insertUser(User user) async {
    user.id = await db.insert(userTable, user.toMap());
    return user;
  }

  Future<User> getUser(int id) async {
    List<Map<String, dynamic>> maps = await db.query(userTable,
        columns: [idColumn, firstnameColumn, lastnameColumn, usernameColumn, passwordColumn, phoneColumn, emailColumn],
        where: '$idColumn = ?',
        whereArgs: [id]);
        maps.length > 0 ? new User.formMap(maps.first) : null;
  }

  Future<int> deleteUser(int id) async {
    return await db.delete(userTable, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int> updateUser(User user) async {
    return db.update(userTable, user.toMap(),
        where: '$idColumn = ?', whereArgs: [user.id]);
  }
  
  Future<List<User>> getAllUser() async {
    await this.open("user.db");
    var res = await db.query(userTable, columns: [idColumn, firstnameColumn, lastnameColumn, usernameColumn, passwordColumn, phoneColumn, emailColumn]);
    List<User> userList = res.isNotEmpty ? res.map((c) => User.formMap(c)).toList() : [];
    return userList;
  }

  Future close() async => db.close();

}