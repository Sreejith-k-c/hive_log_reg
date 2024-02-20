import 'package:flutter/material.dart';
import 'package:hive_log_reg/hivedb.dart';
import 'package:hive_log_reg/home.dart';
import 'package:hive_log_reg/reg.dart';
import 'package:hive_log_reg/user_model.dart';

class Login extends StatelessWidget {
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HiveLogin"),
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
              final users = await HiveDb.instance.getUser();
              checkUserExist(context, users);
            },
            child: Text("Login"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register()));
            },
            child: Text("Not a User? Register Here!!!"),
          )
        ],
      ),
    );
  }

  Future<void> checkUserExist(BuildContext context, List<User> users) async {
    final lemail = email.text.trim();
    final lpass = pass.text.trim();

    if (lemail.isNotEmpty && lpass.isNotEmpty) {
      final foundUser = users.firstWhere((user) => user.email == lemail && user.password == lpass, orElse: () => User(email: '', password: ''));
      if (foundUser.email.isNotEmpty) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HiveHome(email: lemail)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Failed, User Not Found")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fields Must Not Be Empty")),
      );
    }
  }
}
