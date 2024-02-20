import 'package:flutter/material.dart';
import 'package:hive_log_reg/hivedb.dart';
import 'package:hive_log_reg/login.dart';
import 'package:hive_log_reg/user_model.dart';
import 'package:email_validator/email_validator.dart';

class Register extends StatelessWidget {
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Registration"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: 'UserName',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: pass,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'PassWord',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final userlist = await HiveDb.instance.getUser();
              validateSignUp(context, userlist);
            },
            child: Text("Register"),
          ),
        ],
      ),
    );
  }

  void validateSignUp(BuildContext context, List<User> userlist) async {
    final uname = email.text.trim();
    final pwd = pass.text.trim();
    final validateEmail = EmailValidator.validate(uname);
    if (uname.isNotEmpty && pwd.isNotEmpty) {
      if (validateEmail) {
        final userFound = userlist.any((user) => user.email == uname);
        if (userFound) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User Already Exists")),
          );
        } else {
          final validatePassword = validatePassWord(context, pwd);
          if (validatePassword) {
            final user = User(email: uname, password: pwd);
            await HiveDb.instance.addUser(user);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("User Registration Success")),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Enter a Valid Email")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fields Must Not Be Empty")),
      );
    }
  }

  bool validatePassWord(BuildContext context, String pwd) {
    if (pwd.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password length should be > 6")),
      );
      return false;
    }
    return true;
  }
}
